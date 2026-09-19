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
            .background(Color.ypWhite.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            /*.navigationBarHidden(true)*/
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
            } else if viewModel.filteredCities.isEmpty {
                emptyView
            } else {
                citiesListView
            }
        }
    
    // MARK: - Пустое состояние (вне List!)
        private var emptyView: some View {
            VStack(spacing: 16) {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.ypWhite)                
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
        .background(Color.ypWhite)
    }
    
    // MARK: - Пустой список
    
    private var emptyCitiesView: some View {
        VStack(spacing: 16) {
            Text("Город не найден")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack1)
        }
        .frame(maxWidth: .infinity)
        
        .padding(.top, 176)
        .listRowSeparator(.hidden)
        .background(Color.ypWhite)
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
