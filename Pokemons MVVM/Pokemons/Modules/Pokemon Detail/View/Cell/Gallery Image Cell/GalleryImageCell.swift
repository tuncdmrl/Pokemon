//
//  GalleryImageCell.swift
//  Pokemons
//
//  Created by tunc on 4.08.2025.
//

import UIKit
import Kingfisher

class GalleryImageCell: UICollectionViewCell {

  @IBOutlet weak var imageView: UIImageView!
  override func awakeFromNib() {
      super.awakeFromNib()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 8
  }

  func configure(with imageUrl: String) {
      if let url = URL(string: imageUrl) {
          imageView.kf.setImage(with: url)
      } else {
          imageView.image = nil
      }
  }
}
