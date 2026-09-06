//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 06.09.2026.
//

import SwiftUI

struct StationSelectionView: View {
    let cityName: String
    @Binding var selectedStation: String
    
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss

    let stations = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
    
    var filteredStations: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
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
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.leading, 16)
                }
                
                Spacer()
                
                Text("Выбор станции")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)
                
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
                    .foregroundColor(.black)
                    .autocorrectionDisabled()
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color.ypLightGray)
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            // Список станций
            List {
                ForEach(filteredStations, id: \.self) { station in
                    NavigationLink(destination: CarrierListView()) {
                        HStack {
                            Text(station)
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

#Preview {
    StationSelectionView(cityName: "Москва", selectedStation: .constant("Киевский вокзал"))
}
