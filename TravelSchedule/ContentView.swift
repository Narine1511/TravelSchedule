//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 29.08.2026.
//

import SwiftUI
import OpenAPIURLSession
struct NoInternetView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "no_internet")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Нет интернета")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.ypBlack1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct ServerErrorView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "server_error")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Ошибка сервера")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.ypBlack1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}


struct ContentView: View {
    
    @State var from: String = ""
    @State var to: String = ""
    @State private var isSelectingFrom = false
    @State private var isSelectingTo = false
    @State private var isShowingCarrierList = false
    
    @State private var navigateToStationSelection = false
    @State private var selectedCityForStation = ""
    
    @State private var hasNoInternet = false
    @State private var hasServerError = false
    
    var isFormFilled: Bool {
            return !from.isEmpty && !to.isEmpty
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 12) {
                    
                    VStack(spacing: 0) {
                        
                        Button(action: {
                            isSelectingFrom = true
                        }) {
                            HStack {
                                Text(from.isEmpty ? "Откуда" : from)
                                    .padding(.leading, 1)
                                    .foregroundColor(from.isEmpty ? .gray : .black)
                                Spacer()
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 16)
                        }
                        
                        Button(action: {
                            isSelectingTo = true
                        }) {
                            
                            HStack {
                                Text(to.isEmpty ? "Куда" : to)
                                    .padding(.leading, 1)
                                    .foregroundColor(to.isEmpty ? .gray : .black)
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            
                        }
                        
                        .padding(.trailing, 68)
                        .cornerRadius(20)
                        .background(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    Button(action: {
                        let temp = from
                        from = to
                        to = temp
                        
                    }) {
                        Image("change")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.ypBlue)
                            .background(Color.ypWhite)
                            .cornerRadius(40)
                        .padding(12)                   }
                    .cornerRadius(16)
                }
                
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                .background(Color.ypBlue)
                .cornerRadius(24)
                .frame(height: 96)
                .padding(.top, 40)
                
                if isFormFilled {
                    Button(action: {
                        isShowingCarrierList = true
                    }) {
                        Text("Найти")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .padding(.vertical, 16)
                            .background(Color.ypBlue)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                    }
                    .padding(.top, 20)
                    .transition(.opacity)
                }
                
                Spacer()
            }
            
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .background(Color.ypWhite)
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $isSelectingFrom) {
                CitySelectionView(selectedStation: $from)
            }
            .navigationDestination(isPresented: $isSelectingTo) {
                CitySelectionView(selectedStation: $to)
            }
            .navigationDestination(isPresented: $isShowingCarrierList) {
                CarrierListView()
            }
            
            .overlay {
                if hasNoInternet {
                    NoInternetView()
                        .background(Color.ypWhite)
                        .ignoresSafeArea()
                } else if hasServerError {
                    ServerErrorView()
                        .background(Color.ypWhite)
                        .ignoresSafeArea()
                }
            }
            
            .onAppear() {
                testFetchStations()
            }
        }
    }
    // Функция для тестового вызова API
    func testFetchStations() {
        // Создаём Task для выполнения асинхронного кода
        Task {
            do {
                // 1. Создаём экземпляр сгенерированного клиента
                let client = Client(
                    // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                    serverURL: try Servers.Server1.url(),
                    // Указываем, какой транспорт использовать для отправки запросов
                    transport: URLSessionTransport()
                )
                
                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
                let service = NearestStationsService(
                    client: client,
                    apikey: "2d96ceb2-1b65-486f-ab27-da89ad5c2d10"
                )
                
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177, // Пример координат
                    lng: 30.319163, // Пример координат
                    distance: 50    // Пример дистанции
                )
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(stations)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }
}

#Preview {
    ContentView()
}
