//
//  NameCell.swift
//  Pokemons
//
//  Created by tunc on 23.07.2025.
//

import UIKit

final class NameCell: UITableViewCell {
  @IBOutlet weak var detailNameLabel: UILabel!
  
  func configure(name: String) {
    detailNameLabel.text = name.capitalized
  }
}
