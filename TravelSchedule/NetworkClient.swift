//
//  NetworkClient.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 17.09.2026.
//
import Foundation
import OpenAPIURLSession

actor NetworkClient {
    static let shared = NetworkClient()
    
    private let client: Client
    
    private init() {
        do {
            let serverURL = try Servers.Server1.url()
            print("🔵 Server1.url() = \(serverURL.absoluteString)")
            
            self.client = try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            fatalError("Failed to create Client: \(error)")
        }
    }
    
    // MARK: - Copyright
    func getCopyright() async throws -> Copyright {
        let service = CopyrightService(
            client: client,
            apikey: Constants.apiKey
        )
        return try await service.getСopyright(format: "json")
    }
    
    // MARK: - All Stations
    /*func getAllStations(
     lang: String? = nil,
     format: String? = nil
     ) async throws -> AllStations {
     print("🟢 API key: \(Constants.apiKey)")
     let response = try await client.getAllStations(query: .init(
     apikey: Constants.apiKey,
     lang: "ru_RU",
     format: format
     )
     )
     print("🟢 Response received")
     return try response.ok.body.json
     }*/
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: Constants.apiKey,
                                                                    lang: "ru_RU"))
        
        let responseBody = try response.ok.body.html
        
        let limit = 100 * 1024 * 1024 // 50Mb
        var fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try JSONDecoder().decode(AllStations.self, from: fullData)
        
        let russia = allStations.countries?.first { country in
                country.title == "Россия"
            }
        
        return AllStations(countries: [russia].compactMap { $0 })
    }
    
    /* func getAllStations() async throws -> AllStations {
     let apiKey = Constants.apiKey
     let urlString = "https://api.rasp.yandex.net/v3.0/stations_list/?apikey=\(apiKey)&lang=ru_RU&format=json"
     
     guard let url = URL(string: urlString) else {
     throw URLError(.badURL)
     }
     
     print("🔵 Requesting: \(urlString)")
     
     let (data, response) = try await URLSession.shared.data(from: url)
     
     if let httpResponse = response as? HTTPURLResponse {
     print("🔵 HTTP Status: \(httpResponse.statusCode)")
     print("🔵 Content-Type: \(httpResponse.value(forHTTPHeaderField: "Content-Type") ?? "nil")")
     }
     if let text = String(data: data.prefix(500), encoding: .utf8) {
     print("🔵 Response body (first 500 chars):")
     }
     
     return try JSONDecoder().decode(AllStations.self, from: data)
     }*/
    
    // MARK: - Search
    func searchRoutes(
        from: String,
        to: String,
        date: String? = nil,
        transportTypes: String? = nil,
        offset: Int? = nil,
        limit: Int? = nil
    ) async throws -> SearchResponse {
        let response = try await client.getSchedualBetweenStations(query: .init(
            apikey: Constants.apiKey,
            from: from,
            to: to,
            date: date,
            transport_types: transportTypes,
            offset: offset,
            limit: limit
        ))
        return try response.ok.body.json
    }
    
    
    
    // MARK: - CarrierInfo
    func getCarrierInfo(
        code: String
    ) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: Constants.apiKey,
            code: code
        )
        )
        return try response.ok.body.json
    }
    
    
    // MARK: - NearestCity
    func getNearestCity(
        lat: Double,
        lng: Double,
        distance: Int? = nil
    ) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            apikey: Constants.apiKey,
            lat: lat,
            lng: lng,
            distance: distance)
        )
        return try response.ok.body.json
    }
    
    // MARK: - NearestStations
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(apikey: Constants.apiKey,
                                                                        lat: lat,
                                                                        lng: lng,
                                                                        distance: distance)
        )
        return try response.ok.body.json
    }
    // MARK: - RouteStationsService
    func getThreadStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        date: String? = nil
    ) async throws -> ThreadStations {
        let response = try await client.getRouteStations(query: .init(
            apikey: Constants.apiKey,
            uid: uid,
            from: from,
            to: to,
            date: date
        )
        )
        return try response.ok.body.json
    }
    
    // MARK: - StationSchedule
    func getStationSchedule(
        station: String,
        date: String? = nil
    ) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(
            query: .init(
                apikey: Constants.apiKey,
                station: station,
                date: date
            )
        )
        return try response.ok.body.json
    }
}

