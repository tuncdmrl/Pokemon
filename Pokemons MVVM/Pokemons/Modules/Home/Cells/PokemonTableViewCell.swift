//
//  PokemonTableViewCell.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
  @IBOutlet weak var pokemonImageView: UIImageView!
  @IBOutlet weak var pokemonNameLabel: UILabel!
  
  func configure(with pokemon: Pokemon) {
    pokemonNameLabel.text = pokemon.name.capitalized
    
    pokemonImageView.kf.setImage(with: URL(string: pokemon.imageUrl))
  }
}
