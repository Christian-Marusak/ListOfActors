//
//  ActorsViewModel.swift
//  ListOfActors
//
//  Created by Christián on 21/09/2024.
//

import Foundation
import SwiftUI
import os.log


//Trieda ActorsViewModel ktorá má protokol ObservableObject, keďže chcem aby reagovala na zmeny dát
class ActorsViewModel: ObservableObject {
    @Published var actors: [Actor] = []
    @Published var isLoggedIn: Bool = true
    
    //Funkcia na zmenu stavu prihlásenie
    func toggleLoggedIn() {
        isLoggedIn.toggle()
    }
    //Funkcia na stiahnutie dát z API, najprv som si musel otestovať ako sa dostanem k dátam, testoval som to cez aplikáciu Postman. Cez funkciu setValue som si vložil do Headeru application/json aby mi to vrátilo dáta v JSONe a tak ako bolo v zadaní do tela cez funkciu request.httpBody som si vložil key, metoda je http metóda je POST. V prípade že
    func fetchActors() {
        
        //Tu som použil guard let na bezpečné vytvorenie URL. Ak by sa nepodarilo vytvoriť platnú URL (napríklad kôli zlej adrese), funkcia vráti “Invalid URL” a zastaví sa.
        
        guard let url = URL(string: "https://restservice.infotech.sk/Service.svc/getData") else {
            Logger().error("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["APIKey": "1ff7e612-52ec-4bf0-899a-3bb29b07a43c"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger().error("Failed to fetch actors: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger().error("Invalid response")
                return
            }
            switch httpResponse.statusCode {
            case 200:
                Logger().info("Server connected successfully")
                // Pripojenie bolo v poriadku, môžeme prejsť k dekodovaniu API sa pomocou funkcie JSONDecoder do štruktúry ActorResponse.
                guard let data = data else {
                    Logger().error("No data received")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(ActorResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.actors = decodedResponse.actors
                    }
                } catch {
                    print("Failed to decode response: \(error)")
                }
                // chybné hlášky v prípade že sa nepodarilo spojiť zo serverom a vrátil sa chybný kód
            case 400:
                Logger().error("Bad Request (400): The request was invalid.")
            case 401:
                Logger().error("Unauthorized (401): Authentication failed.")
            case 403:
                Logger().error("Forbidden (403): You don't have permission to access this resource.")
            case 404:
                Logger().error("Not Found (404): The requested resource could not be found.")
            case 500:
                Logger().error("Internal Server Error (500): There was a problem with the server.")
            case 502:
                Logger().error("Bad Gateway (502): The server received an invalid response from the upstream server.")
            case 503:
                Logger().error("Service Unavailable (503): The server is currently unavailable.")
            default:
                Logger().error("Unexpected response: \(httpResponse.statusCode)")
            }
        }.resume()
    }
}

struct ActorResponse: Codable {
    let actors: [Actor]
}
