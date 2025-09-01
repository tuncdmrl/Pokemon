import Foundation

final class PokemonDetailResponse: Codable {
  let id: Int
  let name: String
  let weight: Int
  let height: Int
  let baseExperience: Int
  let sprite: Sprite
  let abilities: [PokemonAbilitySlot]
  let types: [PokemonTypeSlot]
  let stats: [PokemonStatSlot]
  
  private enum CodingKeys: String, CodingKey {
    case id, name, weight, height, abilities, types, stats
    case baseExperience = "base_experience"
    case sprite = "sprites"
  }
  
}
extension PokemonDetailResponse: Equatable {
  static func == (lhs: PokemonDetailResponse, rhs: PokemonDetailResponse) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - Sprite
final class Sprite: Codable {
  let frontDefault: String?
  let backDefault: String?
  let frontShiny: String?
  let backShiny: String?
  
  private enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
    case backDefault = "back_default"
    case frontShiny = "front_shiny"
    case backShiny = "back_shiny"
  }
}


// MARK: - Abilities
struct PokemonAbilitySlot: Codable {
  let ability: PokemonAbility
}

struct PokemonAbility: Codable {
  let name: String
}

struct PokemonTypeSlot: Codable {
  let slot: Int
  let type: PokemonType
}

struct PokemonType: Codable {
  let name: String
}
struct PokemonStatSlot: Codable {
  let baseStat: Int
  let stat: PokemonStat
  
  private enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case stat
  }
}

struct PokemonStat: Codable {
  let name: String
}
