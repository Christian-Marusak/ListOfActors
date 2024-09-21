//
//  LoginViewModel.swift
//  ListOfActors
//
//  Created by Christián on 21/09/2024.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    init() {
        loadSavedCredentials()
    }
    func logout() {
        isLoggedIn = false
    }
    func login() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.isLoggedIn = true
            self.saveCredentials()
        }
    }
    
    private func saveCredentials() {
        UserDefaults.standard.set(username, forKey: C.username)
        UserDefaults.standard.set(password, forKey: C.password)
    }
    
    private func loadSavedCredentials() {
        username = UserDefaults.standard.string(forKey: C.username) ?? ""
        password = UserDefaults.standard.string(forKey: C.password) ?? ""
    }
}
