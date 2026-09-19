//
//  CarrierInfoViewModel.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//
import SwiftUI

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    @Published var carrier: Carrier
    
    init(carrier: Carrier) {
        self.carrier = carrier
    }
}
