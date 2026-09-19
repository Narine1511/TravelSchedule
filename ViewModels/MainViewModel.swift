//
//  MainViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//

import Foundation
import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    @Published var from: String = ""
    @Published var to: String = ""
    
    @Published var fromCode: String = ""
    @Published var toCode: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchResults: [Components.Schemas.Segment] = []
    
    private let networkClient = NetworkClient.shared
    
    var isFormFilled: Bool {
        !from.isEmpty && !to.isEmpty && !fromCode.isEmpty && !toCode.isEmpty
    }
    
    // MARK: - Действия
    func swapStations() {
        let tempFrom = from
                let tempFromCode = fromCode
                from = to
                fromCode = toCode
                to = tempFrom
                toCode = tempFromCode
        }
    
    func search() async {
            guard isFormFilled else { return }
        
        
            isLoading = true
            errorMessage = nil
            
            do {
                let response = try await networkClient.searchRoutes(from: fromCode, to: toCode)
                            self.searchResults = response.segments ?? []
                print("🔍 Загружено сегментов: \(searchResults.count)")
            } catch {
                self.errorMessage = error.localizedDescription
                print("❌ Ошибка: \(error)")
            }
                        
                        isLoading = false
                    }
                }
