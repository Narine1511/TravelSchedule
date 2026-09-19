//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

/*import SwiftUI

struct CarrierInfoView: View {
    @StateObject private var viewModel: CarrierInfoViewModel
    
    init(carrier: Carrier) {
        _viewModel = StateObject(wrappedValue: CarrierInfoViewModel(carrier: carrier))
    }
    /*let carrier: Carrier*/
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 1. Логотип
                Image("rzdLogo")
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                
                // 2. Название компании
                Text(viewModel.carrier.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                    .padding(.bottom, 24)
                // 3. Email
                contactSection(
                    title: "E-mail",
                    value: viewModel.carrier.email,
                    url: URL(string: "mailto:\(viewModel.carrier.email)")
                )
                .padding(.bottom, 24)
                
                // 4. Телефон
                contactSection(
                    title: "Телефон",
                    value: viewModel.carrier.phone,
                    url: URL(string: "tel:\(viewModel.carrier.phone.filter { $0.isNumber || $0 == "+" })")
                )
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.ypWhite)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
    }
    @ViewBuilder
    private func contactSection(title: String, value: String, url: URL?) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.ypBlack)
            
            if let url = url {
                Link(destination: url) {
                    Text(value)
                        .font(.system(size: 17))
                        .foregroundColor(.ypBlue)
                }
            } else {
                Text(value)
                    .font(.system(size: 17))
                    .foregroundColor(.ypBlue)
            }
            
        }
        
    }
}
    
    #Preview {
        CarrierInfoView(carrier: .mockRZD)
    }*/

import SwiftUI

struct CarrierInfoView: View {
    @StateObject private var viewModel: CarrierInfoViewModel
    @Environment(\.dismiss) var dismiss
    
    init(carrier: Carrier) {
        _viewModel = StateObject(wrappedValue: CarrierInfoViewModel(carrier: carrier))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // 1. Логотип из URL
                logoView
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                
                // 2. Название компании
                Text(viewModel.carrier.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack1)
                    .padding(.bottom, 24)
                
                // 3. Email (если есть)
                if !viewModel.carrier.email.isEmpty {
                    contactSection(
                        title: "E-mail",
                        value: viewModel.carrier.email,
                        url: URL(string: "mailto:\(viewModel.carrier.email)")
                    )
                    .foregroundColor(.ypBlack1)
                    .padding(.bottom, 24)
                }
                
                // 4. Телефон (если есть)
                if !viewModel.carrier.phone.isEmpty {
                    contactSection(
                        title: "Телефон",
                        value: viewModel.carrier.phone,
                        url: URL(string: "tel:\(viewModel.carrier.phone.filter { $0.isNumber || $0 == "+" })")
                    )
                    .foregroundColor(.ypBlack1)
                }
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.ypBlack1)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.ypBlack1)
            }
        }
    }
    
    // MARK: - Логотип из сети
    @ViewBuilder
    private var logoView: some View {
        AsyncImage(url: viewModel.carrier.logoURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
            case .empty:
                ProgressView()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
            case .failure:
                placeholderLogo
            @unknown default:
                placeholderLogo
            }
        }
    }
    
    // MARK: - Заглушка логотипа
    private var placeholderLogo: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.15))
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .overlay(
                Image(systemName: "tram")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
            )
    }
    
    // MARK: - Секция контакта
    @ViewBuilder
    private func contactSection(title: String, value: String, url: URL?) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.ypBlack1)
            
            if let url = url {
                Link(destination: url) {
                    Text(value)
                        .font(.system(size: 17))
                        .foregroundColor(.ypBlue)
                }
            } else {
                Text(value)
                    .font(.system(size: 17))
                    .foregroundColor(.ypBlue)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarrierInfoView(carrier: .mockRZD)
    }
}
