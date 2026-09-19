//
//  CarrierListViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//
/*import SwiftUI

@MainActor
final class CarrierListViewModel: ObservableObject {
    /* let routeTitle: String = "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)"*/
    /*@Published var hasCarriers: Bool = true*/
    @Published var carriers: [CarrierCellModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient = NetworkClient.shared
    
    var hasCarriers: Bool {
        !carriers.isEmpty
    }
    
    /*init() {
     self.carriers = Self.mockCarriers
     }*/
    func loadCarriers(from segments: [Components.Schemas.Segment]) async {
        isLoading = true
        errorMessage = nil
        
        // Преобразуем Segment → CarrierCellModel
        self.carriers = segments.map { segment in
            makeCellModel(from: segment)
        }
        
        print("🚗 Загружено перевозчиков: \(carriers.count)")
        
        isLoading = false
    }
    
    // MARK: - Преобразование Segment → CarrierCellModel
    private func makeCellModel(from segment: Components.Schemas.Segment) -> CarrierCellModel {
        CarrierCellModel(
            carrierName: segment.thread?.carrier?.title ?? "Перевозчик",
            isTransfer: false,                                    // TODO: логика пересадок
            date: formatDate(segment.departure),
            startTime: formatTime(segment.departure),
            duration: formatDuration(segment.duration),
            endTime: formatTime(segment.arrival),
            logoName: "rzhd_logo"                                 // TODO: из segment.thread?.carrier?.logo
        )
    }
    
    // MARK: - Форматтеры
    private func formatTime(_ isoString: String?) -> String {
        guard let isoString else { return "--:--" }
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else { return "--:--" }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    
    private func formatDate(_ isoString: String?) -> String {
        guard let isoString else { return "" }
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
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
   /* private static let mockCarriers: [CarrierCellModel] = [
            CarrierCellModel(
                carrierName: "РЖД",
                isTransfer: true,
                date: "14 января",
                startTime: "22:30",
                duration: "20 часов",
                endTime: "08:15",
                logoName: "rzhd_logo"
            ),
            CarrierCellModel(
                carrierName: "ФГК",
                isTransfer: false,
                date: "15 января",
                startTime: "22:30",
                duration: "9 часов",
                endTime: "09:00",
                logoName: "fgk_logo"
            ),
            CarrierCellModel(
                        carrierName: "РЖД",
                        isTransfer: true,
                        date: "14 января",
                        startTime: "22:30",
                        duration: "20 часов",
                        endTime: "08:15",
                        logoName: "rzhd_logo"
                    ),
                    CarrierCellModel(
                        carrierName: "ФГК",
                        isTransfer: false,
                        date: "15 января",
                        startTime: "22:30",
                        duration: "9 часов",
                        endTime: "09:00",
                        logoName: "fgk_logo"
                    ),
            CarrierCellModel(
                        carrierName: "РЖД",
                        isTransfer: true,
                        date: "14 января",
                        startTime: "22:30",
                        duration: "20 часов",
                        endTime: "08:15",
                        logoName: "rzhd_logo"
                    )
                ]
            }*/

struct CarrierCellModel: Identifiable {
    let id = UUID()
    let carrierName: String
    let isTransfer: Bool
    let date: String
    let startTime: String
    let duration: String
    let endTime: String
    let logoName: String
}*/
/*import SwiftUI

@MainActor
final class CarrierListViewModel: ObservableObject {
    
    @Published var carriers: [CarrierCellModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient = NetworkClient.shared
    
    var hasCarriers: Bool {
        !carriers.isEmpty
    }
    
    func loadCarriers(from segments: [Components.Schemas.Segment]) async {
        isLoading = true
        errorMessage = nil
        
        self.carriers = segments.map { segment in
            makeCellModel(from: segment)
        }
        
        print("🚗 Загружено перевозчиков: \(carriers.count)")
        
        isLoading = false
    }
    
    private func makeCellModel(from segment: Components.Schemas.Segment) -> CarrierCellModel {
        CarrierCellModel(
            carrierName: segment.thread?.carrier?.title ?? "Перевозчик",
            isTransfer: false,
            date: formatDate(segment.departure),
            startTime: formatTime(segment.departure),
            duration: formatDuration(segment.duration),
            endTime: formatTime(segment.arrival),
            logoName: "rzhd_logo"
        )
    }
    
    private func formatTime(_ isoString: String?) -> String {
        guard let isoString else { return "--:--" }
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else { return "--:--" }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    
    private func formatDate(_ isoString: String?) -> String {
        guard let isoString else { return "" }
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
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

struct CarrierCellModel: Identifiable {
    let id = UUID()
    let carrierName: String
    let isTransfer: Bool
    let date: String
    let startTime: String
    let duration: String
    let endTime: String
    let logoName: String
}*/


import SwiftUI

@MainActor
final class CarrierListViewModel: ObservableObject {
    
    @Published var carriers: [CarrierCellModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient = NetworkClient.shared
    
    var hasCarriers: Bool {
        !carriers.isEmpty
    }
    
    func loadCarriers(from segments: [Components.Schemas.Segment]) async {
        isLoading = true
        errorMessage = nil
        
        self.carriers = segments.map { segment in
            makeCellModel(from: segment)
        }
        
        print("🚗 Загружено перевозчиков: \(carriers.count)")
        
        isLoading = false
    }
    
    // MARK: - Преобразование Segment → CarrierCellModel
    private func makeCellModel(from segment: Components.Schemas.Segment) -> CarrierCellModel {
        CarrierCellModel(
            carrierName: segment.thread?.carrier?.title ?? "Перевозчик",
            isTransfer: false,
            date: formatDate(segment.start_date),
            startTime: formatTime(segment.departure),
            duration: formatDuration(segment.duration),
            endTime: formatTime(segment.arrival),
            logoName: "rzhd_logo"
        )
    }
    // MARK: - Helpers
    
    /// Склеивает дату "2026-10-21" и время "22:18:00" в строку "2026-10-21T22:18:00"
    private func combine(date: String?, time: String?) -> String? {
        guard let date, let time else { return nil }
        return "\(date)T\(time)"
    }
    
    /// Парсит строку "yyyy-MM-dd'T'HH:mm:ss" в Date
    private func parseDate(_ isoString: String?) -> Date? {
        guard let isoString else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Europe/Moscow")
        return formatter.date(from: isoString)
    }
    
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

struct CarrierCellModel: Identifiable {
    let id = UUID()
    let carrierName: String
    let isTransfer: Bool
    let date: String
    let startTime: String
    let duration: String
    let endTime: String
    let logoName: String
}
