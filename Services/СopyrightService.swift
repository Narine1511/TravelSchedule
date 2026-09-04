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
    func getСopyright(format: String?) async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getСopyright(format: String? = nil) async throws -> Copyright {
        // Теперь и здесь латиница!
        let response = try await client.getСopyright(
            query: .init(
                apikey: apikey,
                format: format
            )
        )
        return try response.ok.body.json
    }
}
