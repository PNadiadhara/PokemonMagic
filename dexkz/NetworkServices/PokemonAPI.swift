//
//  PokemonAPI.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import Foundation

final class PokemonAPI {
  
  static func searchPokemon(completionHandler: @escaping (AppError?, [PokemonInfo]?) -> Void) {
    NetworkHelper.shared.performDataTask(endpointURLString: "https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks") { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let pokemonData = try JSONDecoder().decode(Pokemon.self, from: data)
          let cards = pokemonData.cards
          completionHandler(nil, cards)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
}
