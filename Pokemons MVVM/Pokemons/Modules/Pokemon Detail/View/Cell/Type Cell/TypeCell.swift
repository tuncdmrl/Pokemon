//
//  TypeCell.swift
//  Pokemons
//
//  Created by tunc on 28.07.2025.
//

import UIKit

final class TypeCell: UITableViewCell {
  @IBOutlet weak var typesTableView: UITableView!
  @IBOutlet weak var toggleButton: UIButton!
  
  private var types: [String] = []
  
  var toggleButtonTapped: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    typesTableView.delegate = self
    typesTableView.dataSource = self
    
    let nib = UINib(nibName: "TypeItemCell", bundle: nil)
    typesTableView.register(nib, forCellReuseIdentifier: "TypeItemCell")
    
    typesTableView.isScrollEnabled = true
    typesTableView.separatorStyle = .none
    typesTableView.isHidden = true
    typesTableView.rowHeight = UITableView.automaticDimension
    typesTableView.estimatedRowHeight = 30
    selectionStyle = .none
  }
  
  func configure(with types: [String], expanded: Bool) {
    self.types = types
    
    let buttonTitle = expanded ? "Hide Types" : "Show Types"
    toggleButton.setTitle(buttonTitle, for: .normal)
    
    typesTableView.isHidden = !expanded
    typesTableView.reloadData()
    
    DispatchQueue.main.async {
      self.typesTableView.layoutIfNeeded()
    }
  }
  @IBAction func toggleButtonTapped(_ sender: UIButton) {
    
    toggleButtonTapped?()
  }
}
extension TypeCell: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return types.count
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TypeItemCell", for: indexPath) as! TypeItemCell
    let typeName = types[indexPath.row]
    cell.configure(with: typeName)
    
    return cell
  }
}
