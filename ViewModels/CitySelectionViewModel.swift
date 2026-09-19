//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//

import SwiftUI

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCity: String = ""
    @Published var navigateToStation: Bool = false
    
    @Published var cities: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient = NetworkClient.shared
    
    /*   let cities: [String] = [
     "Москва",
     "Санкт Петербург",
     "Сочи",
     "Горный воздух",
     "Краснодар",
     "Казань",
     "Омск"
     ]*/
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func selectCity(_ city: String) {
        selectedCity = city
        navigateToStation = true
    }
    
    func loadCities() async {
        guard cities.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await networkClient.getAllStations()
        
            self.cities = extractCityNames(from: response)
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
private func extractCityNames(from response: AllStations) -> [String] {
    var names: Set<String> = []
    for country in response.countries ?? [] {
        for region in country.regions ?? [] {
            for settlement in region.settlements ?? [] {
                if let title = settlement.title?.trimmingCharacters(in: .whitespaces),
                   !title.isEmpty {
                    names.insert(title)
                }
            }
        }
    }
    
    return Array(names).sorted()
    
}
