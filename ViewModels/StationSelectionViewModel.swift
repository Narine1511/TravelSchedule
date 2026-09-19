//
//  StationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//

import SwiftUI

@MainActor
final class StationSelectionViewModel: ObservableObject {
    let cityName: String

    @Published var searchText: String = ""
    @Published var stations: [Components.Schemas.Station] = []
    @Published var selectedStation: Components.Schemas.Station?
    @Published var navigateBack: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let networkClient = NetworkClient.shared

    var filteredStations: [Components.Schemas.Station] {
        if searchText.isEmpty {
            return stations
        }
        return stations.filter { station in
            (station.title ?? "").localizedCaseInsensitiveContains(searchText)
        }
    }

    init(cityName: String) {
        self.cityName = cityName
    }

    func loadStations() async {
        guard stations.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        do {
            let allStations = try await networkClient.getAllStations()
            self.stations = filterStationsByCity(allStations, cityName: cityName)
            print("🚉 Загружено станций для \(cityName): \(stations.count)")
        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ Ошибка: \(error)")
        }

        isLoading = false
    }

    func selectStation(_ station: Components.Schemas.Station) {
        selectedStation = station
        navigateBack = true
    }

    private func filterStationsByCity(
        _ allStations: AllStations,
        cityName: String
    ) -> [Components.Schemas.Station] {
        var seenKeys = Set<String>()
        var result: [Components.Schemas.Station] = []

        let normalizedCity = cityName
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        for country in allStations.countries ?? [] {
            for region in country.regions ?? [] {
                for settlement in region.settlements ?? [] {
                    let settlementTitle = settlement.title?
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .lowercased() ?? ""

                    guard settlementTitle == normalizedCity else { continue }

                    for station in settlement.stations ?? [] {
                        guard let title = station.title, !title.isEmpty else { continue }

                        let key: String
                        if let yandexCode = station.codes?.yandex_code, !yandexCode.isEmpty {
                            key = yandexCode
                        } else {
                            key = "\(settlementTitle)|\(title)"
                        }

                        guard !seenKeys.contains(key) else { continue }
                        seenKeys.insert(key)
                        result.append(station)
                    }
                }
            }
        }
        return result
    }
}
