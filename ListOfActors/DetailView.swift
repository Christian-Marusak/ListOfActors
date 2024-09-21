//
//  DetailView.swift
//  ListOfActors
//
//  Created by Christián on 19/09/2024.
//

import SwiftUI
import SwiftUI

struct DetailView: View {
    let actor: Actor
    @State private var bgColor = Color.white
    
    var body: some View {
        VStack{
            VStack(alignment: .center, spacing: 20) {
                AsyncImage(url: URL(string: actor.image)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 300)
            }
            .padding()
            VStack(alignment: .leading, content: {
                HStack {
                    Text("Name:")
                        .bold()
                    Text(actor.name)
                }
                HStack{
                    Text("Born:")
                        .bold()
                    Text(actor.dob)
                }
                HStack{
                    Text("Country:")
                        .bold()
                    Text(actor.country)
                }
                HStack{
                    Text("Gender:")
                        .bold()
                    Text(actor.gender)
                }
                HStack{
                    Text("Height:")
                        .bold()
                    Text(actor.height)
                }
                HStack{
                    Text("Weight:")
                        .bold()
                    Text(actor.height)
                }
                HStack{
                    Text("Children:")
                        .bold()
                    Text(actor.children)
                }
                HStack{
                    Text("Spouse:")
                        .bold()
                    Text(actor.spouse)
                }
                HStack{
                    Text("Description:")
                        .bold()
                    Text(actor.description)
                }
            })
            .padding()
                Spacer()
        }
        .background(bgColor)
        .navigationBarItems(trailing: Button("Change BG", action: changeBGColor))
    }
    
    func changeBGColor() {
        bgColor = Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    DetailView(actor: Actor(name: "Actor", description: "Actors description", image: "https://upload.wikimedia.org/wikipedia/commons/1/1c/Kaley_Cuoco_at_PaleyFest_2013.jpg", children: "Actors children", country: "Actors country", dob: "Actors dob", gender: "Actors gender", height: "Actors height", spouse: "Actors spouse", wiki: "Actors wiki"))
}
