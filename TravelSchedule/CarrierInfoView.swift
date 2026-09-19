//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

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
    }
