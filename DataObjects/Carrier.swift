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
}

    extension Carrier {
        static let mockRZD = Carrier(
            id: "112",
            name: "РЖД/ФПК",
            logoURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif"),
            email: "мокinfo@rzd.ru",
            phone: "+7 (800) 775-00-00",
            
        )
    }
