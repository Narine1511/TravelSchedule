//
//  Untitled.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//

import SwiftUI

// MARK: - Временные слоты
enum TimeSlot: String, CaseIterable {
    case morning = "Утро"
    case day = "День"
    case evening = "Вечер"
    case night = "Ночь"
    
    /// Час начала (включительно)
    var startHour: Int {
        switch self {
        case .morning: return 6
        case .day:     return 12
        case .evening: return 18
        case .night:   return 0
        }
    }
    
    /// Час окончания (не включительно)
    var endHour: Int {
        switch self {
        case .morning: return 12
        case .day:     return 18
        case .evening: return 24
        case .night:   return 6
        }
    }
    
    /// Текст для UI
    var displayText: String {
        switch self {
        case .morning: return "Утро 06:00 - 12:00"
        case .day:     return "День 12:00 - 18:00"
        case .evening: return "Вечер 18:00 - 00:00"
        case .night:   return "Ночь 00:00 - 06:00"
        }
    }
}

// MARK: - Опция пересадок
enum TransferOption: String, CaseIterable {
    case yes = "Да"
    case no  = "Нет"
}

// MARK: - Настройки фильтра
struct FilterSettings: Equatable {
    var selectedTimeSlots: Set<TimeSlot> = []
    var transferOption: TransferOption? = nil
    
    var isEmpty: Bool {
        selectedTimeSlots.isEmpty && transferOption == nil
    }
}

// MARK: - ViewModel
@MainActor
final class FilterViewModel: ObservableObject {
    
    // MARK: - Данные
    @Published var selectedTimeSlots: Set<TimeSlot> = []
    @Published var transferOption: TransferOption? = nil
    
    // MARK: - Computed
    var hasSelection: Bool {
        !selectedTimeSlots.isEmpty || transferOption != nil
    }
    
    // MARK: - Действия
    
    /// Переключить слот времени
    func toggleTimeSlot(_ slot: TimeSlot) {
        if selectedTimeSlots.contains(slot) {
            selectedTimeSlots.remove(slot)
        } else {
            selectedTimeSlots.insert(slot)
        }
    }
    
    /// Проверить, выбран ли слот
    func isSelected(_ slot: TimeSlot) -> Bool {
        selectedTimeSlots.contains(slot)
    }
    
    /// Выбрать опцию пересадок
    func selectTransfer(_ option: TransferOption) {
        transferOption = option
    }
    
    /// Проверить, выбрана ли опция
    func isTransferSelected(_ option: TransferOption) -> Bool {
        transferOption == option
    }
    
    /// Получить текущие настройки фильтра
    func currentSettings() -> FilterSettings {
        FilterSettings(
            selectedTimeSlots: selectedTimeSlots,
            transferOption: transferOption
        )
    }
}
