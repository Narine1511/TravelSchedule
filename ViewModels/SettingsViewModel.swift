//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 19.09.2026.
//
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Тёмная тема
    @AppStorage("isDarkThemeEnabled") var isDarkThemeEnabled: Bool = false
    
    // MARK: - Информация о приложении
    let apiInfoText: String = "Приложение использует API «Яндекс.Расписания»"
    let versionText: String = "Версия 1.0 (beta)"
}
