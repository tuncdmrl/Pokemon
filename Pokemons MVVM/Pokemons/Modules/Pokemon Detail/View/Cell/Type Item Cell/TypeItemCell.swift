//
//  TypeItemCell.swift
//  Pokemons
//
//  Created by tunc on 28.07.2025.
//

import UIKit

final class TypeItemCell: UITableViewCell {
  @IBOutlet weak var typeNameLabel: UILabel!
  
  func configure(with type: String) {
    typeNameLabel.text = type.capitalized
  }
}
