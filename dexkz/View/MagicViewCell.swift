//
//  MagicViewCell.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class MagicViewCell: UICollectionViewCell {
    
    @IBOutlet weak var magicCardLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var magicCardImg: UIImageView!
    
    func setMagicCardCell(magicCard: CardInfo) {
        self.magicCardLoadingIndicator.startAnimating()
        
        ImageHelper.shared.fetchImage(urlString: magicCard.imageUrl ?? "nil") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                self.magicCardImg.image = image
                self.magicCardLoadingIndicator.stopAnimating()
            }
        }
    }
}
