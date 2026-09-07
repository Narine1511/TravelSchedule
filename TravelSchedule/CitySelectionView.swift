//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 05.09.2026.
//

import SwiftUI

struct CitySelectionView: View {
    @Binding var selectedStation: String
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    let cities = [
        "Москва",
        "Санкт Петербург",
        "Сочи",
        "Горный воздух",
        "Краснодар",
        "Казань",
        "Омск"
    ]
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Заголовок
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.ypBlack1)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.leading, 16) // Отступ кнопки от края экрана
                }
                
                Spacer() // Spacer() прижимает кнопку влево и текст в центр
                
                Text("Выбор города")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.ypBlack1)
                
                Spacer()
                
                Color.clear.frame(width: 24, height: 24)
            }
            .padding(.vertical, 16)
            
            // Поисковая строка
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 18))
                
                TextField("Введите запрос", text: $searchText)
                    .foregroundColor(.ypBlack1)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color.ypLightGray)
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            // Список городов
            List {
                
                if filteredCities.isEmpty {
                    VStack(spacing: 16) {
                        Text("Город не найден")
                            .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack1)}
                    
                    .frame(maxWidth: .infinity)
                    .background(Color.ypWhite)
                    .padding(.top, 176)
                    .listRowSeparator(.hidden)
                    /*.listRowBackground(Color.clear)*/
                } else {
                    ForEach(filteredCities, id: \.self) { city in
                        NavigationLink(destination: StationSelectionView(cityName: city, selectedStation: $selectedStation)) {
                            HStack {
                                Text(city)
                                    .foregroundColor(.ypBlack1)
                                    .font(.system(size: 17))
                                
                                
                                Spacer()
                            }
                            .background(Color.ypWhite)
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.ypWhite)
                    }
                    .background(Color.ypWhite)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
           .scrollContentBackground(.hidden) // Делаем фон списка прозрачным*/
        }
        .background(Color.ypWhite)
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CitySelectionView(selectedStation: .constant("Москва"))
}
