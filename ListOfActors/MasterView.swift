//
//  MasterView.swift
//  ListOfActors
//
//  Created by Christián on 19/09/2024.
//
import SwiftUI
import os.log
import SwiftUI

struct MasterView: View {
    @StateObject var viewModel = ActorsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.actors) { actor in
                NavigationLink(destination: DetailView(actor: actor)) {
                    HStack {
                        AsyncImage(url: URL(string: actor.image)) { image in
                            image.resizable()
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
            .onAppear(perform: viewModel.fetchActors)
            .navigationTitle("Actors")
        }
    }
}

#Preview {
    MasterView()
}
