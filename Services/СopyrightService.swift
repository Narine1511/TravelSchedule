//
//  СopyrightService.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 31.08.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright(format: String?) async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright(format: String? = nil) async throws -> Copyright {
        // Теперь и здесь латиница!
        let response = try await client.getCopyright(
            query: .init(
                apikey: apikey,
                format: format
            )
        )
        return try response.ok.body.json
    }
}
