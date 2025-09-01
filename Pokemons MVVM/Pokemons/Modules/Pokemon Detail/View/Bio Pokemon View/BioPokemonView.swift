
//
//  BioPokemonView.swift
//  Pokemons
//
//  Created by tunc on 5.08.2025.
//

import UIKit

final class BioPokemonView: UIView {
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var toggleButton: UIButton!
  
  private var isExpanded = false
  var onToggle: (() -> Void)?
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadFromNib()
  }
  
  private func loadFromNib() {
    Bundle.main.loadNibNamed("BioPokemonView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  func configure(with text: String, isExpanded: Bool) {
    self.isExpanded = isExpanded
    
    titleLabel.text = "Bio (EN)"
    bioLabel.text = text
    
    updateUI()
  }
  private func updateUI() {
    bioLabel.isHidden = !isExpanded
    titleLabel.isHidden = !isExpanded
    
    let buttonTitle = isExpanded ? "Hide Bio" : "Show Bio"
    toggleButton.setTitle(buttonTitle, for: .normal)
    
    setNeedsLayout()
    layoutIfNeeded()
  }
  @IBAction func toggleButtonTapped(_ sender: UIButton) {
    
    isExpanded.toggle()
    updateUI()
    onToggle?()
  }
}
