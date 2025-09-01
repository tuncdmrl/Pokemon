//
//  ImageCell.swift
//  Pokemons
//
//  Created by tunc on 23.07.2025.
//

import UIKit
import Kingfisher

final class ImageCell: UITableViewCell {
  @IBOutlet weak var detailImageView: UIImageView!
  
  func configure(with imageUrl: String) {
    if let url = URL(string: imageUrl) {
      detailImageView.kf.setImage(with: url)
    } else {
      detailImageView.image = nil
    }
  }
}
