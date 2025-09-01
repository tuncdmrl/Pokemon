//
//  PokemonSpeciesResponse.swift
//  Pokemons
//
//  Created by tunc on 5.08.2025.
//

import Foundation

struct PokemonSpeciesResponse: Codable {
  let flavorTextEntries: [FlavorTextEntry]
  
  enum CodingKeys: String, CodingKey {
    case flavorTextEntries = "flavor_text_entries"
  }
}

struct FlavorTextEntry: Codable {
  let flavorText: String
  let language: LanguageEntry
  
  enum CodingKeys: String, CodingKey {
    case flavorText = "flavor_text"
    case language
  }
}

struct LanguageEntry: Codable {
  let name: String
}
extension PokemonSpeciesResponse {
  var englishFlavorText: String? {
    return flavorTextEntries.first(where: { $0.language.name == "en" })?.flavorText
  }
}

