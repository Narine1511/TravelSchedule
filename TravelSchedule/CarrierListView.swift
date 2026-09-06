//
//  CarrierListView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 06.09.2026.
//

import SwiftUI

struct CarrierListView: View {
    let routeTitle: String = "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)"
    @Environment(\.dismiss) var dismiss
    @State private var isShowingFilter = false
    var body: some View {
        
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 8)
                .padding(.leading, 16)
                Spacer()
                
                Text(routeTitle)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(0..<5) { index in
                            CarrierCardView(
                                carrierName: index % 2 == 0 ? "РЖД" : "ФГК",
                                isTransfer: index % 2 == 0,
                                date: index % 2 == 0 ? "14 января" : "15 января",
                                startTime: "22:30",
                                duration: index % 2 == 0 ? "20 часов" : "9 часов",
                                endTime: index % 2 == 0 ? "08:15" : "09:00",
                                logoName: index % 2 == 0 ? "rzhd_logo" : "fgk_logo")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 120)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
                .navigationBarHidden(true)
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    isShowingFilter = true
                }) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 32)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(UIColor.systemBackground).opacity(0), Color(UIColor.systemBackground)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .navigationDestination(isPresented: $isShowingFilter) {
                FilterView()
                
            }
    }
}

struct CarrierCardView: View {
    let carrierName: String
    let isTransfer: Bool
    let date: String
    let startTime: String
    let duration: String
    let endTime: String
    let logoName: String
    
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Image(logoName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(carrierName)
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.black)
                                        
                                        if isTransfer {
                                            Text("С пересадкой в Костроме")
                                                .font(.system(size: 13))
                                                .foregroundColor(.red)
                                        }
                                    }
                    Spacer()
                                    
                                    Text(date)
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }
                HStack(spacing: 0) {
                                Text(startTime)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                    HStack(spacing: 4) {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(height: 1)
                                        
                                        Text(duration)
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                        
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(height: 1)
                                    }
                                    .padding(.horizontal, 8)
                                    
                                    Text(endTime)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.black)
                                }
                            }
            .padding(16)
                    .background(Color.gray.opacity(0.08))
                    .cornerRadius(16)
                        }
    
                    }

#Preview {
    CarrierListView()
}
