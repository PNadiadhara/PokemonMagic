//
//  PokemonViewCell.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class PokemonViewCell: UICollectionViewCell {
  
  
  @IBOutlet weak var pokemonImage: UIImageView!
  
  @IBOutlet weak var pokemonActivityIndicator: UIActivityIndicatorView!
  
  func setUpImage(pokemon: PokemonInfo) {
    
    self.pokemonActivityIndicator.startAnimating()
    
    ImageHelper.shared.fetchImage(urlString: pokemon.imageUrl) { (appError, image) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let image = image {
        self.pokemonImage.image = image
        self.pokemonActivityIndicator.stopAnimating()
      }
    }
  }
  
  override func prepareForReuse() {
    
    pokemonImage.image = nil
    
  }
  
}
