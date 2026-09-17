//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 13.09.2026.
//

import Foundation

struct Carrier: Identifiable, Hashable {
    let id: String
    let name: String
    let logoURL: URL?
    let email: String
    let phone: String

    static let mockRZD = Carrier(
            id: "rzd",
            name: "ОАО «РЖД»",
            logoURL: nil,
            email: "i.logzkina@yandex.ru",
            phone: "+7 (904) 329-27-71"
        )
    }
