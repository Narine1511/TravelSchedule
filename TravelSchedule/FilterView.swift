//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 06.09.2026.
//
import SwiftUI

struct FilterView: View {
    
    @StateObject private var viewModel = FilterViewModel()
    @Environment(\.dismiss) var dismiss
    
    /// Колбэк: вызывается при нажатии "Применить"
    var onApply: (FilterSettings) -> Void = { _ in }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Навбар
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.ypBlack1)
                        .font(.system(size: 20, weight: .medium))
                }
                .padding(.leading, 16)
                
                Spacer()
            }
            .padding(.vertical, 16)
            
            // Контент
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    // MARK: - Время отправления
                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack1)
                        .textCase(nil)
                        .padding(.bottom, 4)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    ForEach(TimeSlot.allCases, id: \.self) { slot in
                        timeSlotRow(slot)
                    }
                    
                    // MARK: - Пересадки
                    Text("Показывать варианты с пересадками")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack1)
                        .textCase(nil)
                        .padding(.bottom, 4)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    ForEach(TransferOption.allCases, id: \.self) { option in
                        transferRow(option)
                    }
                }
                .padding(.top, 0)
                .padding(.bottom, 120)
            }
            .scrollContentBackground(.hidden)
            .background(Color.ypWhite)
        }
        .background(Color.ypWhite.ignoresSafeArea())
        .safeAreaInset(edge: .bottom) {
            if viewModel.hasSelection {
                Button(action: {
                    let settings = viewModel.currentSettings()
                    onApply(settings)                
                    dismiss()
                }) {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 32)
                        .background(Color.ypBlue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }
    
    // MARK: - Строка слота времени
    private func timeSlotRow(_ slot: TimeSlot) -> some View {
        HStack {
            Text(slot.displayText)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.ypBlack1)
            
            Spacer()
            
            Button(action: {
                viewModel.toggleTimeSlot(slot)
            }) {
                Image(systemName: viewModel.isSelected(slot) ? "checkmark.square.fill" : "square")
                    .font(.system(size: 20))
                    .foregroundColor(.ypBlack1)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    // MARK: - Строка пересадок
    private func transferRow(_ option: TransferOption) -> some View {
        HStack {
            Text(option.rawValue)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.ypBlack1)
            
            Spacer()
            
            Button(action: {
                viewModel.selectTransfer(option)
            }) {
                Image(systemName: viewModel.isTransferSelected(option) ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 20))
                    .foregroundColor(.ypBlack1)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    NavigationStack {
        FilterView()
    }
}
