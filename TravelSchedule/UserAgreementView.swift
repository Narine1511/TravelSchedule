//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import SwiftUI

struct UserAgreementView: View {
    @StateObject private var viewModel = UserAgreementViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack2)
                    .padding(.bottom, 8)
                
                Text(viewModel.introText)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlack2)
                
                Text(viewModel.section1Title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack2)
                    .padding(.top, 24)
                
                Text(viewModel.section1Text)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlack2)
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 16)
        }
        .background(Color.ypWhite)
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
}

#Preview {
    NavigationStack {
        UserAgreementView()
    }
}
