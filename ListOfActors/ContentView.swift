//
//  ContentView.swift
//  ListOfActors
//
//  Created by Christián on 19/09/2024.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoggedIn {
                MasterView()
            } else {
                VStack {
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    
                    Button(action: viewModel.login) {
                        Text("Login")
                            .frame(minWidth: 100, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
