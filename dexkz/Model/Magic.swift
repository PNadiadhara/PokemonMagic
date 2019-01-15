//
//  Magic.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import Foundation

//your model should obtain: name, imageUrl, text, and foreignNames. Within foreignNames you need the name, text, imageUrl, and language.

struct Magic : Codable {
   let cards : [CardInfo]
}

struct CardInfo: Codable {
    let foreignNames : [NotEnglish]
    let imageUrl : String?
    let name : String
    let text : String 
}

struct NotEnglish : Codable {
    let name : String
    let text : String
    let imageUrl : String
    let language : String
}
