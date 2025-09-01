//
//  AbilityItemCell.swift
//  Pokemons
//
//  Created by tunc on 24.07.2025.
//

import UIKit

final class AbilityItemCell: UITableViewCell {
  @IBOutlet weak var abilityNameLabel: UILabel!
  
  func configure(with ability: String) {
    abilityNameLabel.text = ability.capitalized
  }
}
