//
//  PokemonDetailViewController.swift
//  Pokemons
//
//  Created by tunc on 25.07.2025.
//

import UIKit
import Kingfisher

final class PokemonDetailViewController: UIViewController {
  @IBOutlet weak var detailTableView: UITableView!
  
  var pokemon: Pokemon?
  var abilities: [PokemonAbilitySlot] = []
  var types: [PokemonTypeSlot] = []
  var stats: [PokemonStatSlot] = []
  
  var isAbilitiesExpanded = false
  var isTypesExpanded = false
  var isStatsExpanded = false
  var isGalleryExpanded = false
  var isBioExpanded = false
  
  private var bioText: String?
  private let viewModel = PokemonDetailViewModel()
  
  private enum DetailSection: Int, CaseIterable {
    case name, image, abilities, types, stats, gallery, bio
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Pokemon Detail"
    view.backgroundColor = .systemBackground
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .close,
      target: self,
      action: #selector(closeButtonTapped)
    )
    
    detailTableView.dataSource = self
    detailTableView.delegate = self
    
    let cellsToRegister: [(nibName: String, identifier: String)] = [
      ("NameCell", "detailNameCell"),
      ("ImageCell", "detailImageCell"),
      ("AbilityCell", "detailAbilityCell"),
      ("TypeCell", "detailTypeCell"),
      ("StatsCell", "detailStatsCell"),
      ("GalleryCell", "detailGalleryCell"),
      ("BioPokemonsCell", "BioPokemonsCell")
    ]
    for cell in cellsToRegister {
      detailTableView.register(UINib(nibName: cell.nibName, bundle: nil), forCellReuseIdentifier: cell.identifier)
    }
    if let pokemon = pokemon {
      viewModel.getPokemonDetail(id: pokemon.idAsInt)
      viewModel.getPokemonSpecies(id: pokemon.idAsInt)
    }
    viewModel.onPokemonDetailLoaded = { [weak self] detail in
      guard let self = self else { return }
      self.abilities = detail.abilities
      self.types = detail.types
      self.stats = detail.stats
      self.detailTableView.reloadData()
    }
    viewModel.onPokemonSpeciesLoaded = { [weak self] species in
      guard let self = self else { return }
      self.bioText = species.englishFlavorText
      let indexPath = IndexPath(row: DetailSection.bio.rawValue, section: 0)
      self.detailTableView.reloadRows(at: [indexPath], with: .automatic)
    }
  }
  @objc func closeButtonTapped() {
    dismiss(animated: true)
  }
}
extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DetailSection.allCases.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let section = DetailSection(rawValue: indexPath.row) else { return 44 }
    
    switch section {
    case .name:
      return 50
    case .image:
      return 175
    case .abilities:
      return isAbilitiesExpanded && !abilities.isEmpty ? CGFloat(abilities.count) * 30 + 44 + 10 : 44
    case .types:
      return isTypesExpanded && !types.isEmpty ? CGFloat(types.count) * 30 + 44 + 10 : 44
    case .stats:
      return isStatsExpanded ? 150 : UITableView.automaticDimension
    case .gallery:
      return isGalleryExpanded ? 250 : UITableView.automaticDimension
    case .bio:
      return isBioExpanded ? 250 : 44
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let pokemon = pokemon else { return UITableViewCell() }
    guard let section = DetailSection(rawValue: indexPath.row) else { return UITableViewCell() }
    
    switch section {
    case .name:
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailNameCell", for: indexPath) as! NameCell
      cell.configure(name: pokemon.name)
      
      return cell
    case .image:
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailImageCell", for: indexPath) as! ImageCell
      cell.configure(with: pokemon.imageUrl)
      return cell
      
    case .abilities:
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailAbilityCell", for: indexPath) as! AbilityCell
      cell.configure(with: abilities.map { $0.ability.name.capitalized }, expanded: isAbilitiesExpanded)
      cell.onToggle = { [weak self] in
        self?.isAbilitiesExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      return cell
      
    case .types:
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailTypeCell", for: indexPath) as! TypeCell
      cell.configure(with: types.map { $0.type.name.capitalized }, expanded: isTypesExpanded)
      cell.toggleButtonTapped = { [weak self] in
        self?.isTypesExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      return cell
      
    case .stats:
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailStatsCell", for: indexPath) as! StatsCell
      cell.configure(with: stats, expanded: isStatsExpanded)
      cell.toggleButtonTapped = { [weak self] in
        self?.isStatsExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      return cell
      
    case .gallery:
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailGalleryCell", for: indexPath) as! GalleryCell
      cell.configure(with: viewModel.galleryImageUrls, expanded: isGalleryExpanded, pokemonName: pokemon.name)
      cell.toggleButtonTapped = { [weak self] in
        self?.isGalleryExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      return cell
      
    case .bio:
      let cell = tableView.dequeueReusableCell(withIdentifier: "BioPokemonsCell", for: indexPath) as! BioPokemonsCell
      if let text = bioText {
        cell.configure(with: text, isExpanded: isBioExpanded)
        cell.onToggle = { [weak self] in
          guard let self = self else { return }
          self.isBioExpanded.toggle()
          tableView.beginUpdates()
          tableView.endUpdates()
        }
      }
      return cell
    }
  }
}

