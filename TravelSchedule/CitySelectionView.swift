//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 05.09.2026.
//

import SwiftUI

struct CitySelectionView: View {
    @StateObject private var viewModel = CitySelectionViewModel()
    @Binding var selectedStation: String
    @Binding var selectedStationCode: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                searchView
                contentView
            }
            .background(Color.ypWhite)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .task {
                await viewModel.loadCities()
            }
            .navigationDestination(isPresented: $viewModel.navigateToStation) {
                StationSelectionView(
                    cityName: viewModel.selectedCity,
                    stationTitle: $selectedStation,
                    stationCode: $selectedStationCode
                )
            }
        }
    }
    
    // MARK: - Заголовок
    
    private var headerView: some View {
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
            
            Text("Выбор города")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.ypBlack1)
            
            Spacer()
            
            Color.clear.frame(width: 24, height: 24)
        }
        .padding(.vertical, 16)
    }
    
    // MARK: - Поиск
    
    private var searchView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 18))
            
            TextField("Введите запрос", text: $viewModel.searchText)
                .foregroundColor(.ypBlack2)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(Color.ypLightGray)
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    // MARK: - Контент (загрузка / ошибка / список)
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            loadingView
        } else if let error = viewModel.errorMessage {
            errorView(error)
        } else {
            citiesListView
        }
    }
    
    // MARK: - Загрузка
    
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Ошибка
    
    private func errorView(_ error: String) -> some View {
        VStack(spacing: 16) {
            Text("Не удалось загрузить города")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.ypBlack1)
            
            Text(error)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Список городов
    
    private var citiesListView: some View {
        List {
            if viewModel.filteredCities.isEmpty {
                emptyCitiesView
            } else {
                citiesRows
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
    
    // MARK: - Пустой список
    
    private var emptyCitiesView: some View {
        VStack(spacing: 16) {
            Text("Город не найден")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack1)
        }
        .frame(maxWidth: .infinity)
        .background(Color.ypWhite)
        .padding(.top, 176)
        .listRowSeparator(.hidden)
    }
    
    // MARK: - Строки списка
    
    private var citiesRows: some View {
        ForEach(viewModel.filteredCities, id: \.self) { city in
            cityRow(city)
        }
    }
    
    // MARK: - Одна строка
    
    private func cityRow(_ city: String) -> some View {
        HStack {
            Text(city)
                .foregroundColor(.ypBlack2)
                .font(.system(size: 17))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.ypBlack2)
                .font(.system(size: 14))
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.selectCity(city)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.ypWhite)
    }
}

#Preview {
    CitySelectionView(
        selectedStation: .constant("Москва"),
        selectedStationCode: .constant("")
    )
}

/*import SwiftUI

struct CitySelectionView: View {
    @StateObject private var viewModel = CitySelectionViewModel()
    
    @Binding var selectedStation: String
    /*@State private var searchText = ""
    @State private var selectedCity = ""
    @State private var navigateToStation = false*/
    @Environment(\.dismiss) var dismiss
    
    /*let cities = [
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
                    
                    TextField("Введите запрос", text: $viewModel.searchText)
                        .foregroundColor(.ypBlack2)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color.ypLightGray)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                // Список городов
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text("Не удалось загрузить города")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.ypBlack1)
                        
                        Text(error)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    List {
                        
                        if viewModel.filteredCities.isEmpty {
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
                            ForEach(viewModel.filteredCities, id: \.self) { city in
                                
                                HStack {
                                    Text(city)
                                        .foregroundColor(.ypBlack2)
                                        .font(.system(size: 17))
                                    
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.ypBlack2)
                                        .font(.system(size: 14))
                                }
                                
                                /*.background(Color.ypWhite)*/
                                .padding(.vertical, 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.selectCity(city)
                                    /*navigateToStation = true*/
                                }                  .listRowSeparator(.hidden)
                                    .listRowBackground(Color.ypWhite)
                            }
                            .background(Color.ypWhite)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden) // Делаем фон списка прозрачным
                }
            }
            
            .background(Color.ypWhite)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            
            .task {
                await viewModel.loadCities()
            }
            .navigationDestination(isPresented: $viewModel.navigateToStation) {
                StationSelectionView(cityName: viewModel.selectedCity, selectedStation: $selectedStation)
            }
        }
    }
}

#Preview {
    CitySelectionView(selectedStation: .constant("Москва"))
}*/
