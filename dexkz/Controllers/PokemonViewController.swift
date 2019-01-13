//
//  ViewController.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!

  private var pokemon = [PokemonInfo]() {
    didSet{
      DispatchQueue.main.async {
        self.pokemonCollectionView.reloadData()
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonCollectionView.dataSource = self
    pokemonCollectionView.delegate = self
    getPokemonDataFromAPI()
    
  }
  
  
  private func getPokemonDataFromAPI(){
    PokemonAPI.searchPokemon{ (appError, pokemon) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let pokemon = pokemon {
        self.pokemon = pokemon
        dump(pokemon)
      }
    }
  }
  
  
}

extension PokemonViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemon.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = pokemonCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonViewCell else {return UICollectionViewCell()}
    
    let currentPokemon = pokemon[indexPath.item]
    
    cell.setUpImage(pokemon: currentPokemon)
    
    return cell
    
  }
  
}

extension PokemonViewController: UICollectionViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
  }
}
