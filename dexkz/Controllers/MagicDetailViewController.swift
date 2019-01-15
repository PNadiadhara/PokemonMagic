//
//  MagicDetailViewController.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class MagicDetailViewController: UIViewController {

    var passedMagicCardInfo : CardInfo!
    
    @IBOutlet weak var magicButton: UIButton!
    
    
    @IBOutlet weak var magicDetailedCollectionView: UICollectionView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        magicDetailedCollectionView.dataSource = self
        magicDetailedCollectionView.delegate = self

        view.backgroundColor = .clear
        
    }
    @IBAction func magicButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension MagicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passedMagicCardInfo.foreignNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicDetailedCollectionView.dequeueReusableCell(withReuseIdentifier: "MagicDetailedCell", for: indexPath) as? MagicDetailedCollectionViewCell else { return UICollectionViewCell()}
        let currentMagicCardLanguage = passedMagicCardInfo.foreignNames[indexPath.item]
        cell.language.text = currentMagicCardLanguage.language
        cell.magicCardDescription.text = currentMagicCardLanguage.text
        cell.magicCardName.text = currentMagicCardLanguage.name
        ImageHelper.shared.fetchImage(urlString: passedMagicCardInfo.foreignNames[indexPath.item].imageUrl) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                cell.magicCardImage.image = image
            }
        }
    return cell
    }
}

extension MagicDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: magicDetailedCollectionView.bounds.width, height: magicDetailedCollectionView.bounds.height)
        
    }
    
}


