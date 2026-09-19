//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 06.09.2026.
//

import SwiftUI

struct StationSelectionView: View {
    let cityName: String
    @Binding var stationTitle: String
    @Binding var stationCode: String
    
    /* @State private var searchText = ""*/
    @StateObject private var viewModel: StationSelectionViewModel
    @Environment(\.dismiss) var dismiss
    
    init(
        cityName: String,
        stationTitle: Binding<String>,
        stationCode: Binding<String>
    ) {
        self.cityName = cityName
        self._stationTitle = stationTitle
        self._stationCode = stationCode
        _viewModel = StateObject(wrappedValue: StationSelectionViewModel(cityName: cityName))
    }
    
    /*  let stations = [
     "Киевский вокзал",
     "Курский вокзал",
     "Ярославский вокзал",
     "Белорусский вокзал",
     "Савеловский вокзал",
     "Ленинградский вокзал"
     ]*/
    
    
    /*   var filteredStations: [String] {
     if searchText.isEmpty {
     return stations
     } else {
     return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
     }
     }*/
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Заголовок
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.ypBlack2)
                            .font(.system(size: 20, weight: .medium))
                            .padding(.leading, 16)
                    }
                    
                    Spacer()
                    
                    Text("Выбор станции")
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
                    
                    TextField("Введите запрос", text: $viewModel.searchText)
                        .foregroundColor(.ypBlack2)
                        .autocorrectionDisabled()
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.searchText = ""
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
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1)
                        .tint(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else if viewModel.filteredStations.isEmpty {
                    VStack(spacing: 16) {
                        Text("Станция не найдена")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.ypBlack1)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    
                    // Список станций
                    List {
                        
                        if viewModel.filteredStations.isEmpty {
                            VStack(spacing: 16) {
                                Text("Станция не найдена")
                                    .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.ypBlack1)}
                            
                            .frame(maxWidth: .infinity)
                            .background(Color.ypWhite)
                            .padding(.top, 176)
                            .listRowSeparator(.hidden)
                            /*.listRowBackground(Color.clear)*/
                        } else {
                            
                            ForEach(Array(viewModel.filteredStations.enumerated()), id: \.offset) { _, station in
                                Button(action: {
                                    stationTitle = station.title ?? ""
                                    stationCode = station.codes?.yandex_code ?? ""
                                    dismiss()
                                    /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                     dismiss()
                                     }*/
                                }) {
                                    HStack {
                                        Text(station.title ?? "Без названия")
                                            .foregroundColor(.ypBlack2)
                                            .font(.system(size: 17))
                                        
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.ypBlack2)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.vertical, 8)
                                }
                                .listRowBackground(Color.ypWhite)
                                .listRowSeparator(.hidden)
                            }
                        }
                    }
                    .listRowBackground(Color.ypWhite)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            
            .background(Color.ypWhite)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
        }
        .task {
            await viewModel.loadStations()
        }
    }
}

#Preview {
    StationSelectionView(
        cityName: "Москва",
        stationTitle: .constant(""),
        stationCode: .constant("")
    )
}
