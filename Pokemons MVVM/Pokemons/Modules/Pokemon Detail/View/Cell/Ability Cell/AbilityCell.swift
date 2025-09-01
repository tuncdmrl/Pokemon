//
//  AbilityCell.swift
//  Pokemons
//
//  Created by tunc on 24.07.2025.
//

import UIKit

final class AbilityCell: UITableViewCell {
  @IBOutlet weak var abilitiesTableView: UITableView!
  @IBOutlet weak var toggleButton: UIButton!
  
  private var abilities: [String] = []
  
  var onToggle: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    abilitiesTableView.delegate = self
    abilitiesTableView.dataSource = self
    
    let nib = UINib(nibName: "AbilityItemCell", bundle: nil)
    abilitiesTableView.register(nib, forCellReuseIdentifier: "AbilityItemCell")
    
    abilitiesTableView.isScrollEnabled = true
    abilitiesTableView.separatorStyle = .none
    abilitiesTableView.isHidden = true
    abilitiesTableView.rowHeight = UITableView.automaticDimension
    abilitiesTableView.estimatedRowHeight = 30
  }
  
  func configure(with abilities: [String], expanded: Bool) {
    self.abilities = abilities
    
    let buttonTitle = expanded ? "Hide Abilities" : "Show Abilities"
    
    toggleButton.setTitle(buttonTitle, for: .normal)
    
    abilitiesTableView.isHidden = !expanded
    
    abilitiesTableView.reloadData()
  }
  
  @IBAction func toggleButtonTapped(_ sender: UIButton) {
    onToggle?()
  }
}
extension AbilityCell: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return abilities.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityItemCell", for: indexPath) as! AbilityItemCell
    let abilityName = abilities[indexPath.row]
    cell.configure(with: abilityName)
    
    return cell
  }
}
