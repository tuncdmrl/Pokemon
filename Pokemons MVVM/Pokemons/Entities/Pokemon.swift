//
//  Pokemon.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import Foundation

final class Pokemon: Codable {
  let name: String
  let url: String
  
  var id: String {
    let cleanUrl = url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    let components = cleanUrl.components(separatedBy: "/")
    
    return components.last ?? "1"
  }
  var imageUrl: String {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
  }
}
extension Pokemon {
  var idAsInt: Int {
    return Int(id) ?? 0
  }
}
