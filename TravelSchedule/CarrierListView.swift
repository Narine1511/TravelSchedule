//
//  CarrierListView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 06.09.2026.
//

import SwiftUI

struct CarrierListView: View {
    
    // MARK: - Входные данные
    let searchResults: [Components.Schemas.Segment]
    let routeTitle: String
    
    // MARK: - Состояние
    @Environment(\.dismiss) var dismiss
    @State private var isShowingFilter = false
    @StateObject private var viewModel = CarrierListViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(UIColor.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Кнопка "Назад"
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.ypBlack1)
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 8)
                .padding(.leading, 16)
                
                // Заголовок
                Text(routeTitle)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.ypBlack1)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                // Контент
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.ypBlue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !viewModel.hasCarriers {
                    emptyView
                } else {
                    carriersListView
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            filterButton
        }
        .task {
            await viewModel.loadCarriers(from: searchResults)
        }
        .navigationDestination(isPresented: $isShowingFilter) {
            // 👇 Передаём колбэк onApply
            FilterView { settings in
                viewModel.applyFilter(settings)
            }
        }
    }
    
    // MARK: - Пустое состояние
    private var emptyView: some View {
        VStack(spacing: 16) {
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Список
    private var carriersListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.carriers) { carrier in
                    NavigationLink {
                        CarrierInfoView(carrier: carrier.carrier)
                    } label: {
                        CarrierCardView(cell: carrier)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 120)
        }
    }
    
    // MARK: - Кнопка "Уточнить время"
    private var filterButton: some View {
        Button(action: { isShowingFilter = true }) {
            Text("Уточнить время")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.ypBlue)
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(UIColor.ypWhite).opacity(0),
                    Color(UIColor.ypWhite)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// MARK: - Card View
struct CarrierCardView: View {
    let cell: CarrierCellModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                
                AsyncImage(url: cell.logoURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .empty:
                        ProgressView()
                    case .failure:
                        placeholderLogo
                    @unknown default:
                        placeholderLogo
                    }
                }
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(cell.carrierName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.ypBlack1)
                    
                    if cell.isTransfer {
                        Text("С пересадкой")
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                    }
                }
                Spacer()
                
                Text(cell.date)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 0) {
                Text(cell.startTime)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.ypBlack1)
                
                HStack(spacing: 4) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                    
                    Text(cell.duration)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }
                .padding(.horizontal, 8)
                
                Text(cell.endTime)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.ypBlack1)
            }
        }
        .padding(16)
        .background(Color.gray.opacity(0.08))
        .cornerRadius(16)
    }
    
    private var placeholderLogo: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.2))
            .overlay(
                Image(systemName: "tram")
                    .foregroundColor(.gray)
            )
    }
}

#Preview {
    NavigationStack {
        CarrierListView(
            searchResults: [],
            routeTitle: "Москва → Санкт-Петербург"
        )
    }
}
