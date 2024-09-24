//
//  DetailView.swift
//  ListOfActors
//
//  Created by Christián on 19/09/2024.
//

import SwiftUI

struct DetailView: View {
    // Načítanie modelu Actor
    let actor: Actor
    // premenná typu State ktorá kontroluje zmenu farieb, defaultne je nastavená na farbu Default kôli Dark a Light modu iPhonu
    @State private var bgColor = Color.default
    var body: some View {
        
        // Zobrazenie
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
            // zobrazenie informácií o hercovi v VStacku v ktorom sú Hstacky aby sa dalo zobraziť časť textu boldom a časť light fontom
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
        // Zmena farby pozadia podľa bgColor
        .navigationBarItems(trailing: Button("Change BG", action: changeBGColor))
    }
    
    func changeBGColor() {
        //Funkcia na zmenu farby pozadia
        bgColor = Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    //Preview s modelovými dátami
    DetailView(actor: Actor(name: "Actor", description: "Actors description", image: "https://upload.wikimedia.org/wikipedia/commons/1/1c/Kaley_Cuoco_at_PaleyFest_2013.jpg", children: "Actors children", country: "Actors country", dob: "Actors dob", gender: "Actors gender", height: "Actors height", spouse: "Actors spouse", wiki: "Actors wiki"))
}
