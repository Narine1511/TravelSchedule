//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Наринэ  Овсепян on 29.08.2026.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    @State var from: String = ""
    @State var to: String = ""
    var body: some View {
        VStack {
            
            HStack(spacing: 12)
            {
                
                VStack(spacing: 0) {
                    TextField("Откуда", text: $from)
                        .padding(.vertical, 12)
                        .padding(.leading, 1)
                    
                    
                    TextField("Куда", text: $to)
                        .padding(.vertical, 12)
                        .padding(.leading, 1)
                }
                .frame(height: 96)
                .padding(.leading, 16)
                .padding(.trailing, 68)
                .background(Color.white)
                .cornerRadius(20)
                
                Button(action: {
                    
                }) {
                    Image("change")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.blue) 
                        .background(Color.white)
                        .cornerRadius(40)
                        .padding(12)                   }
                .cornerRadius(16)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.blue)
            .cornerRadius(24)
            Spacer()
        }
        
        .padding(.top, 16)
        .padding(.horizontal, 16)
        .onAppear {
            testFetchStations()
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
