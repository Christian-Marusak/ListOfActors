//
//  ContentView.swift
//  ListOfActors
//
//  Created by Christián on 19/09/2024.
//

import SwiftUI

struct LoginView: View {
    //Premenná typu StateObject ktorá obsahuje viewModel na celu logiku tohoto View
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            //Kontrola či je užívateľ prihlásený, ak hej ukáže MasterView ak nie vráti VStack s komponentami
            if viewModel.isLoggedIn {
                MasterView()
            } else {
                VStack {
                    Image(.loginView)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height:300)
                    Text("Find your favorite actor")
                        .font(.largeTitle)
                        .bold()
                    
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
                    //Tlačidlo na prihlásenie
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
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
