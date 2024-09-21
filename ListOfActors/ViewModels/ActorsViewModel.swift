//
//  ActorsViewModel.swift
//  ListOfActors
//
//  Created by Christián on 21/09/2024.
//

import Foundation
import SwiftUI

class ActorsViewModel: ObservableObject {
    @Published var actors: [Actor] = []
    @Published var isLoggedIn: Bool = true
    
    func toggleLoggedIn() {
        isLoggedIn.toggle()
    }
    
    func fetchActors() {
        guard let url = URL(string: "https://restservice.infotech.sk/Service.svc/getData") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["APIKey": "1ff7e612-52ec-4bf0-899a-3bb29b07a43c"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch actors: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
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
        }.resume()
    }
}

struct ActorResponse: Codable {
    let actors: [Actor]
}
