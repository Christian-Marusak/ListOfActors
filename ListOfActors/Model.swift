//
//  Model.swift
//  ListOfActors
//
//  Created by Christián on 21/09/2024.
//

import Foundation

struct Actor: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let image: String
    let children: String
    let country: String
    let dob: String
    let gender: String
    let height: String
    let spouse: String
    let wiki: String
}
