//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 06.09.2026.
//

import SwiftUI

struct FilterView: View {
    
    @State private var isMorningSelected = false
    @State private var isDaySelected = false
    @State private var isEveningSelected = false
    @State private var isNightSelected = false
    
    @State private var transferOption: String? = nil
    
    @Environment(\.dismiss) var dismiss
    
    var hasSelection: Bool {
        return isMorningSelected || isDaySelected || isEveningSelected || isNightSelected || transferOption != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                }
                .padding(.leading, 16)
                
                Spacer()
                
            }
            .padding(.vertical, 16)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .textCase(nil)
                        .padding(.bottom, 4)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    HStack {
                        Text("Утро 06:00 - 12:00")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            isMorningSelected.toggle()
                        }) {
                            Image(systemName: isMorningSelected ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    HStack {
                        Text("День 12:00 - 18:00")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            isDaySelected.toggle()
                        }) {
                            Image(systemName: isDaySelected ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    HStack {
                        Text("Вечер 18:00 - 00:00")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            isEveningSelected.toggle()
                        }) {
                            Image(systemName: isEveningSelected ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    HStack {
                        Text("Ночь 00:00 - 06:00")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            isNightSelected.toggle()
                        }) {
                            Image(systemName: isNightSelected ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    Text("Показывать варианты с пересадками")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .textCase(nil)
                        .padding(.bottom, 4)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    HStack {
                        Text("Да")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            transferOption = "Да"
                        }) {
                            Image(systemName: transferOption == "Да" ? "largecircle.fill.circle" : "circle")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    HStack {
                        Text("Нет")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            transferOption = "Нет"
                        }) {
                            Image(systemName: transferOption == "Нет" ? "largecircle.fill.circle" : "circle")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                }
                .padding(.top, 0)
                .padding(.bottom, 120)
            }
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        
        .safeAreaInset(edge: .bottom) {
            if hasSelection {
                Button(action: {
                    dismiss()
                }) {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 32)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        FilterView()
    }
}
