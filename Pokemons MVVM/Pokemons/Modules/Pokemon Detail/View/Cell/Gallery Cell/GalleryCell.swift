//
//  GalleryCell.swift
//  Pokemons
//
//  Created by tunc on 4.08.2025.
//

import UIKit

final class GalleryCell: UITableViewCell {
  @IBOutlet weak var toggleButton: UIButton!
  @IBOutlet weak var galleryCollectionView: UICollectionView!
  
  var toggleButtonTapped: (() -> Void)?
  private var imageUrls: [String] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    galleryCollectionView.delegate = self
    galleryCollectionView.dataSource = self
    
    let nib = UINib(nibName: "GalleryImageCell", bundle: nil)
    galleryCollectionView.register(nib, forCellWithReuseIdentifier: "GalleryImageCell")
    
    toggleButton.addTarget(self, action: #selector(toggleTapped), for: .touchUpInside)
    
    galleryCollectionView.showsHorizontalScrollIndicator = false
    
  }
  func configure(with imageUrls: [String], expanded: Bool, pokemonName: String) {
    self.imageUrls = imageUrls
    galleryCollectionView.isHidden = !expanded
    
    let capitalizedName = pokemonName.capitalized
    let buttonTitle = expanded ? "Hide pictures of \(capitalizedName)" : "See all other pictures of \(capitalizedName)"
    toggleButton.setTitle(buttonTitle, for: .normal)
    
    galleryCollectionView.reloadData()
  }
  
  @objc private func toggleTapped() {
    toggleButtonTapped?()
  }
}

extension GalleryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageUrls.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryImageCell", for: indexPath) as! GalleryImageCell
    cell.configure(with: imageUrls[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200, height: 200)
  }
}
