//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 29.08.2026.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @AppStorage("isDarkThemeEnabled") private var isDarkThemeEnabled = false
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkThemeEnabled ? .dark : .light)
        }
    }
}
