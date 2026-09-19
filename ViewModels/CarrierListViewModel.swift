//
//  CarrierListViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//

import SwiftUI

@MainActor
final class CarrierListViewModel: ObservableObject {
    
    // MARK: - Данные
    @Published var carriers: [CarrierCellModel] = []           // все (отфильтрованные)
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    // MARK: - Внутренние данные
    private var allCarriers: [CarrierCellModel] = []           // 👈 полный список (до фильтрации)
    private var currentFilter: FilterSettings = FilterSettings()
    
    // MARK: - Computed
    var hasCarriers: Bool {
        !carriers.isEmpty
    }
    
    // MARK: - Загрузка
    func loadCarriers(from segments: [Components.Schemas.Segment]) async {
        isLoading = true
        errorMessage = nil
        
        // Конвертируем сегменты в модели
        self.allCarriers = segments.map { segment in
            return makeCellModel(from: segment)
        }
        
        // Применяем текущий фильтр (изначально — пустой)
        applyFilter(currentFilter)
        
        print("🚗 Загружено перевозчиков: \(carriers.count)")
        
        isLoading = false
    }
    
    // MARK: - Фильтрация
    func applyFilter(_ settings: FilterSettings) {
        currentFilter = settings
        
        // Если фильтр пустой — показываем всех
        if settings.isEmpty {
            carriers = allCarriers
            return
        }
        
        // Фильтруем по выбранным слотам времени
        if !settings.selectedTimeSlots.isEmpty {
            carriers = allCarriers.filter { carrier in
                // Извлекаем час из startTime ("22:18")
                guard let hour = extractHour(from: carrier.startTime) else { return false }
                
                // Проверяем, попадает ли час в один из выбранных слотов
                return settings.selectedTimeSlots.contains { slot in
                    isHour(hour, inSlot: slot)
                }
            }
        } else {
            carriers = allCarriers
        }
        
        // Фильтрация по пересадкам (пока — заглушка, всё false)
        if let transferOption = settings.transferOption {
            switch transferOption {
            case .yes:
                // Оставляем только с пересадками (у нас таких нет)
                carriers = carriers.filter { $0.isTransfer }
            case .no:
                // Оставляем только без пересадок
                carriers = carriers.filter { !$0.isTransfer }
            }
        }
        
        print("🎨 После фильтра: \(carriers.count) из \(allCarriers.count)")
    }
    
    // MARK: - Вспомогательные методы
    
    /// Извлекает час из строки "22:18" → 22
    private func extractHour(from timeString: String) -> Int? {
        let components = timeString.split(separator: ":")
        guard let firstComponent = components.first else { return nil }
        return Int(firstComponent)
    }
    
    /// Проверяет, попадает ли час в слот
    private func isHour(_ hour: Int, inSlot slot: TimeSlot) -> Bool {
        // Особый случай для ночи (00:00 - 06:00)
        if slot == .night {
            return hour >= 0 && hour < 6
        }
        // Особый случай для вечера (18:00 - 00:00)
        if slot == .evening {
            return hour >= 18 && hour < 24
        }
        return hour >= slot.startHour && hour < slot.endHour
    }
    
    // MARK: - Преобразование Segment → CarrierCellModel
    private func makeCellModel(from segment: Components.Schemas.Segment) -> CarrierCellModel {
        let apiCarrier = segment.thread?.carrier
        
        let carrier = Carrier(
            id: "\(apiCarrier?.code ?? 0)",
            name: apiCarrier?.title ?? "Перевозчик",
            logoURL: URL(string: apiCarrier?.logo ?? ""),
            email: apiCarrier?.email ?? "",
            phone: apiCarrier?.phone ?? ""
        )
        
        return CarrierCellModel(
            carrierName: carrier.name,
            isTransfer: false,
            date: formatDate(segment.start_date),
            startTime: formatTime(segment.departure),
            duration: formatDuration(segment.duration),
            endTime: formatTime(segment.arrival),
            logoURL: carrier.logoURL,
            carrier: carrier
        )
    }
    
    // MARK: - Форматтеры
    
    private func formatTime(_ timeString: String?) -> String {
        guard let timeString, timeString.count >= 5 else { return "--:--" }
        let index = timeString.index(timeString.startIndex, offsetBy: 5)
        return String(timeString[..<index])
    }
    
    private func formatDate(_ dateString: String?) -> String {
        guard let dateString else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ru_RU")
        guard let date = formatter.date(from: dateString) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        return outputFormatter.string(from: date)
    }
    
    private func formatDuration(_ seconds: Int?) -> String {
        guard let seconds else { return "" }
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        if hours > 0 {
            return "\(hours) ч \(minutes) мин"
        } else {
            return "\(minutes) мин"
        }
    }
}

// MARK: - Модель ячейки
struct CarrierCellModel: Identifiable {
    let id = UUID()
    let carrierName: String
    let isTransfer: Bool
    let date: String
    let startTime: String
    let duration: String
    let endTime: String
    let logoURL: URL?
    let carrier: Carrier
}
