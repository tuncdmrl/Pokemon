//
//  PokemonResponse.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import Foundation

final class PokemonResponse: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [Pokemon]
}
