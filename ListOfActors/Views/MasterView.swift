//
//  MasterView.swift
//  ListOfActors
//
//  Created by Christián on 19/09/2024.
//
import SwiftUI
import os
struct MasterView: View {
    // premenná typu StateObject ktorá obsahuje všetku logiku tohoto view
    @StateObject var viewModel = ActorsViewModel()
    
    var body: some View {
        NavigationView {
            // Ak je užívateľa prihlásený zobrazi List s hercami, ak nie zobrazí LoginView
            if viewModel.isLoggedIn {
                List(viewModel.actors) { actor in
                    NavigationLink(destination: DetailView(actor: actor)) {
                        HStack {
                            AsyncImage(url: URL(string: actor.image)) { image in
                                image.resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(actor.name).font(.headline)
                                Text(actor.description).font(.subheadline).lineLimit(2)
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    //Vypísanie UserDefault, kontrolný logger ktorý mi vypísal UserDefault aby som skontroloval správne uloženie mena a hesla, akonáhle nebol potrebný zakomentoval som ho aby nebola konzola zbytočne zanesená nepotrebnými iformáciami
                    //                    Logger().error("printing out UserDefaults \(UserDefaults.standard.dictionaryRepresentation())")
                })
                .onAppear(perform: viewModel.fetchActors)
                .navigationTitle("Actors")
                .navigationBarItems(trailing: Button(action: viewModel.toggleLoggedIn , label: {
                    Text("Log out")
                }))
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MasterView()
}
