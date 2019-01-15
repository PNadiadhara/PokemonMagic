//
//  PokemonDetailViewController.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
  
  var cardDetails: PokemonInfo!
  
  @IBOutlet weak var pokemonDetailedImage: UIImageView!
  
  @IBOutlet weak var detailedPokemonCollectionView: UICollectionView!
  
  @IBOutlet weak var cardActivityIndicator: UIActivityIndicatorView!
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    detailedPokemonCollectionView.dataSource = self
    detailedPokemonCollectionView.delegate = self
    setImage(pokemon: cardDetails)
    let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
    view.addGestureRecognizer(tap)
  }

  @objc func goBack () {
    dismiss(animated: true, completion: nil)
  }
  
  
  func setImage(pokemon:PokemonInfo) {
    
    self.cardActivityIndicator.startAnimating()
    ImageHelper.shared.fetchImage(urlString: cardDetails.imageUrlHiRes) { (appError, image) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let image = image {
        self.pokemonDetailedImage.image = image
        self.cardActivityIndicator.stopAnimating()
      }
    }
  }
  
  

  
}

extension PokemonDetailViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return cardDetails.attacks.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = detailedPokemonCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonDetailedCell", for: indexPath) as? PokemonDetailedCell else {return UICollectionViewCell()}
    
    let currentCard = cardDetails.attacks[indexPath.item]
    
    cell.attackName.text = currentCard.name
    cell.attackLevel.text = currentCard.damage
    cell.attackDescription.text = currentCard.text
    if cell.attackDescription.text != ""{
      cell.attackDescription.backgroundColor = .white
    }
    
    return cell
    
  }
  
}

extension PokemonDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize.init(width: detailedPokemonCollectionView.bounds.width, height: detailedPokemonCollectionView.bounds.height)
    
  }
  
}

