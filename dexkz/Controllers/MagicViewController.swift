//
//  MagicViewController.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {

    @IBOutlet weak var magicCollection: UICollectionView!
    var magicCardInfo = [CardInfo](){
        didSet{
            DispatchQueue.main.async {
                self.magicCollection.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMagicCards()
        magicCollection.dataSource = self
        magicCollection.delegate = self 
       
    }
    
    private func setUpMagicCards () {
        MagicAPIClient.getMagicCardInfoFromAPI { (appErr, data) in
            if let appErr = appErr {
                print("print \(appErr)")
            }
            if let data = data {
                self.magicCardInfo = data
                
            }
        }
    }

}


extension MagicViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCardInfo.filter{$0.imageUrl != nil}.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicCollection.dequeueReusableCell(withReuseIdentifier: "MagicSceneCell", for: indexPath) as? MagicViewCell else { fatalError("magic cell not found")}
        let currentMagicCard = magicCardInfo[indexPath.item]
        cell.setMagicCardCell(magicCard: currentMagicCard)
        return cell
    }
    
    
    
}

extension MagicViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let magicStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let magicPopUp = magicStoryBoard.instantiateViewController(withIdentifier: "MagicDetailPopUp") as? MagicDetailViewController else { return }
        
        magicPopUp.modalPresentationStyle = .overCurrentContext
        magicPopUp.passedMagicCardInfo = magicCardInfo[indexPath.item]
        present(magicPopUp, animated: true, completion: nil)
    }
}

extension MagicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: (magicCollection.bounds.width - 20) / 3, height: magicCollection.bounds.height / 4)
        
    }
}

