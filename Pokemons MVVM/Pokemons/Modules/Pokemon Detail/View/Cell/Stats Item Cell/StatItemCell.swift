//
//  StatItemCell.swift
//  Pokemons
//
//  Created by tunc on 28.07.2025.
//
import UIKit

class StatItemCell: UITableViewCell {
  @IBOutlet weak var statNameLabel: UILabel!
  @IBOutlet weak var statValueLabel: UILabel!
  
  func configure(with stat: PokemonStatSlot) {
    
    statNameLabel.text = stat.stat.name.capitalized
    statValueLabel.text = "\(stat.baseStat)"
  }
}

