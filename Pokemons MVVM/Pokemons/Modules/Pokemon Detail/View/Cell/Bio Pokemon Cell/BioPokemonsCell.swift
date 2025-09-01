//
//  BioPokemonsCell.swift
//  Pokemons
//
//  Created by tunc on 5.08.2025.
//

import UIKit

final class BioPokemonsCell: UITableViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var bioView: BioPokemonView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    bioView.onToggle = nil
  }
  func configure(with text: String, isExpanded: Bool) {
    bioView.configure(with: text, isExpanded: isExpanded)
  }
  var onToggle: (() -> Void)? {
    get {
      return bioView.onToggle
    }
    set {
      bioView.onToggle = newValue
    }
  }
}
