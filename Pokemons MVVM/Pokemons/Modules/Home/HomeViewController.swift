//
//  HomeViewController.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import UIKit

final class HomeViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private let viewModel = HomeViewModel()
  private var pokemons: [Pokemon] = []
  
  private var offset = 0
  private let limit = 20
  private var pageNumber = 0
  
  private var isLoading = false
  private var allPokemonsLoaded = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Pokemons"
    
    let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "PokemonTableViewCell")
    
    viewModel.onPokemonsLoaded = { [weak self] newPokemons in
      guard let self = self else { return }
      
      self.isLoading = false
      
      if newPokemons.isEmpty {
        self.allPokemonsLoaded = true
        
        return
      }
      
      self.pokemons.append(contentsOf: newPokemons)
      
      self.offset += newPokemons.count
      
      self.tableView.reloadData()
    }
    
    loadPokemons()
  }
  
  private func loadPokemons() {
    guard !isLoading && !allPokemonsLoaded else { return }
    
    isLoading = true
    
    viewModel.getPokemons(with: offset, limit: limit, pageNumber: pageNumber)
    
    pageNumber += 1
  }
}
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
    let pokemon = pokemons[indexPath.row]
    cell.configure(with: pokemon)
    
    return cell
  }
}
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedPokemon = pokemons[indexPath.row]
    
    guard selectedPokemon.url.split(separator: "/").compactMap({ Int($0) }).last != nil else {
      return
    }
    
    let storyboard = UIStoryboard(name: "PokemonDetail", bundle: nil)
    guard let navVC = storyboard.instantiateInitialViewController() as? UINavigationController,
          let detailVC = navVC.viewControllers.first as? PokemonDetailViewController else {
      return
    }
    
    detailVC.pokemon = selectedPokemon
    navVC.modalPresentationStyle = .fullScreen
    
    present(navVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastElement = pokemons.count - 1
    
    if indexPath.row == lastElement - 5 {
      loadPokemons()
    }
  }
}
