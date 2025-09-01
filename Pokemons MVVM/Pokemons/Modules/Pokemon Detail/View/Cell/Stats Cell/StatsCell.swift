//
//  StatsCell.swift
//  Pokemons
//
//  Created by tunc on 28.07.2025.
//

import UIKit

final class StatsCell: UITableViewCell {
  @IBOutlet weak var toggleButton: UIButton!
  @IBOutlet weak var statsTableView: UITableView!
  
  private var stats: [PokemonStatSlot] = []
  private var isExpanded: Bool = false
  
  var toggleButtonTapped: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    statsTableView.delegate = self
    statsTableView.dataSource = self
    
    let nib = UINib(nibName: "StatItemCell", bundle: nil)
    statsTableView.register(nib, forCellReuseIdentifier: "StatItemCell")
    
    statsTableView.isScrollEnabled = true
    statsTableView.separatorStyle = .none
    statsTableView.isHidden = true
    statsTableView.rowHeight = UITableView.automaticDimension
    statsTableView.estimatedRowHeight = 30
    selectionStyle = .none
  }
  
  func configure(with stats: [PokemonStatSlot], expanded: Bool) {
      self.stats = stats
      self.isExpanded = expanded
      
      let buttonTitle = expanded ? "Hide Stats" : "Show Stats"
      toggleButton.setTitle(buttonTitle, for: .normal)
      
      statsTableView.isHidden = !expanded
      
      DispatchQueue.main.async {
          self.statsTableView.reloadData()
          self.statsTableView.layoutIfNeeded()
      }
  }
  
  @IBAction func toggleButtonTapped(_ sender: UIButton) {
    toggleButtonTapped?()
  }
}
extension StatsCell: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stats.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StatItemCell", for: indexPath) as! StatItemCell
    let stat = stats[indexPath.row]
    cell.configure(with: stat)
    
    return cell
  }
}
