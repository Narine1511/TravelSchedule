//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 05.09.2026.
//

import SwiftUI

struct MainTabView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .ypGray.withAlphaComponent(0.3)
        appearance.shadowImage = UIImage()
        UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance

    }
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image("schedule")
                        .renderingMode(.template)
                }
            
            Text("Экран поездок")
                .tabItem {
                    Image("settings")
                        .renderingMode(.template)
                }
            
        }
        .tint(.ypBlack1)
    }
}

#Preview {
    MainTabView()
}
