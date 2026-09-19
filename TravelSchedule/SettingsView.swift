//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

struct SettingsView: View {
    /* @AppStorage("isDarkThemeEnabled") private var isDarkThemeEnabled = false*/
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    
                    HStack{
                        Text("Темная тема")
                            .font(.system(size: 17))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Toggle("", isOn: $viewModel.isDarkThemeEnabled)
                            .labelsHidden()
                            .tint(.ypBlue)
                    }
                    .padding(.vertical, 16)
                    
                    NavigationLink {
                        UserAgreementView()
                    } label: {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.ypBlack2)
                        }
                        .padding(.vertical, 16)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                Spacer()
                
                VStack(spacing: 6) {
                    Text(viewModel.apiInfoText)
                    Text(viewModel.versionText)
                }
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypBlack2)
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
            }
            
            .background(Color.ypWhite.ignoresSafeArea())
        }
    }
}

#Preview {
    SettingsView()
}
