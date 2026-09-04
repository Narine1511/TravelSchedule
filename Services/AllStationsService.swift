//
//  AllStationsService.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 31.08.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations(lang: String?, format: String?) async throws -> AllStations
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations(
        lang: String? = nil,
        format: String? = nil
    ) async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey,
            lang: lang,
            format: format
        )
        )
        return try response.ok.body.json
    }
}
