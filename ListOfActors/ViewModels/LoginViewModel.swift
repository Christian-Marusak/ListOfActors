//
//  LoginViewModel.swift
//  ListOfActors
//
//  Created by Christián on 21/09/2024.
//

import Foundation
import SwiftUI
// Trieda LoginViewModel ktorý konformuje protokol ObservableObject, taktiež z dôvodu aby sme vedeli pozorovať zmeny ktoré sa udejú na premenných označených ako Published
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    
    
    init() {
        loadSavedCredentials()
    }
    // Funkcia na odhlásenie z aplikácie
    func logout() {
        isLoggedIn = false
    }
    
    // prihlásenie s uložením údajov a 2 sekundovým "načítavaním"
    func login() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.isLoggedIn = true
            self.saveCredentials()
        }
    }
    // uloženie do UserDefaults pre kľúč password a username uložených v konštantách
    private func saveCredentials() {
        UserDefaults.standard.set(username, forKey: C.username)
        UserDefaults.standard.set(password, forKey: C.password)
    }
    // čítanie z UserDefaults pre kľúč password a username uložených v konštantách
    private func loadSavedCredentials() {
        username = UserDefaults.standard.string(forKey: C.username) ?? ""
        password = UserDefaults.standard.string(forKey: C.password) ?? ""
    }
}
