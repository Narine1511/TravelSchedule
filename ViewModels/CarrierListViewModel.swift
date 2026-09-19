//
//  CarrierListViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//
import SwiftUI

@MainActor
final class CarrierListViewModel: ObservableObject {
    let routeTitle: String = "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)"
    @Published var hasCarriers: Bool = true
    @Published var carriers: [CarrierCellModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient = NetworkClient.shared
    
    init() {
        self.carriers = Self.mockCarriers
    }
    func loadCarriers() async {
    }
    
    private static let mockCarriers: [CarrierCellModel] = [
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
