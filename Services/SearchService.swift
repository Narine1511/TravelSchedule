//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 31.08.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResponse = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func searchRoutes(
        from: String,
        to: String,
        date: String?,
        transportTypes: String?,
        offset: Int?,
        limit: Int?
    ) async throws -> SearchResponse
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func searchRoutes(
        from: String,
        to: String,
        date: String?,
        transportTypes: String?,
        offset: Int?,
        limit: Int?) async throws -> SearchResponse {
            let response = try await client.getSchedualBetweenStations(query: .init(
                apikey: apikey,
                from: from,
                to: to,
                date: date,
                transport_types: transportTypes,
                offset: offset,
                limit: limit
            ))
            return try response.ok.body.json
    }
}
