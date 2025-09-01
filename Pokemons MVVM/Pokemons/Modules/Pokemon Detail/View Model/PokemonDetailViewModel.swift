//
//  PokemonDetailViewModel.swift
//  Pokemons
//
//  Created by tunc on 15.07.2025.
//

import Foundation
import RxSwift

final class PokemonDetailViewModel {
  
  private let apiService: APIServiceProtocol = APIService()
  private let disposeBag = DisposeBag()
  
  var onPokemonDetailLoaded: ((PokemonDetailResponse) -> Void)?
  var onPokemonSpeciesLoaded: ((PokemonSpeciesResponse) -> Void)?
  
  private var detail: PokemonDetailResponse?
  var bioText: String?
  
  var galleryImageUrls: [String] {
    [
      detail?.sprite.frontDefault,
      detail?.sprite.backDefault,
      detail?.sprite.frontShiny,
      detail?.sprite.backShiny
    ].compactMap { $0 }
  }
  
  func getPokemonDetail(id: Int) {
    apiService.getPokemonDetail(with: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] detail in
        guard let self = self, let detail = detail else { return }
        
        self.detail = detail
        self.onPokemonDetailLoaded?(detail)
      }, onFailure: { error in
        print("❌ Pokemon detay çekme hatası: \(error)")
      })
      .disposed(by: disposeBag)
  }
  
  func getPokemonSpecies(id: Int) {
    apiService.getPokemonSpecies(id: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] species in
        guard let self = self, let species = species else { return }
        
        let englishText = species.flavorTextEntries
          .first(where: { $0.language.name == "en" })?
          .flavorText
          .replacingOccurrences(of: "\n", with: " ")
          .replacingOccurrences(of: "\u{000c}", with: " ")
        
        self.bioText = englishText
        self.onPokemonSpeciesLoaded?(species)
        
      }, onFailure: { error in
        print("❌ Biyografi çekme hatası: \(error)")
      })
      .disposed(by: disposeBag)
  }
}
