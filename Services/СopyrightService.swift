//
//  СopyrightService.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 31.08.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Сopyright = Components.Schemas.CopyrightResponse

protocol СopyrighServiceProtocol {
    func getСopyrigh(format: String?) async throws -> Сopyrigh
}

final class СopyrighService: СopyrighServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getСopyrigh(
        format: String? = nil
    ) async throws -> AllStations {
        let response = try await client.getСopyrigh(query: .init(
            apikey: apikey,
            format: format
        )
        )
        return try response.ok.body.json
    }
}
