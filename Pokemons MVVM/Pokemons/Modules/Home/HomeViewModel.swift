//
//  HomeViewModel.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import Foundation
import RxSwift

final class HomeViewModel {
  private var apiService: APIServiceProtocol = APIService()
  
  private let disposeBag = DisposeBag()
  
  var onPokemonsLoaded: (([Pokemon]) -> Void)?
  var onPokemonDetailLoaded: ((PokemonDetailResponse) -> Void)?
  
  func getPokemons(with offset: Int, limit: Int, pageNumber: Int) {
    apiService.getPokemons(offset: offset, limit: limit, pageNumber: pageNumber)
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] pokemons in
        guard let pokemons = pokemons else { return }
        
        self?.onPokemonsLoaded?(pokemons.results)
      }).disposed(by: disposeBag)
  }
  
  func getPokemonDetail(with id: Int) {
    apiService.getPokemonDetail(with: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] pokemonDetailResponse in
        guard let pokemonDetailResponse = pokemonDetailResponse else { return }
        
        self?.onPokemonDetailLoaded?(pokemonDetailResponse)
      }).disposed(by: disposeBag)
  }
}
