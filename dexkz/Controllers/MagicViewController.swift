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
        return magicCardInfo.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicCollection.dequeueReusableCell(withReuseIdentifier: "MagicSceneCell", for: indexPath) as? MagicViewCell else { fatalError("magic cell not found")}
        guard let url = URL.init(string: magicCardInfo.in)
        return cell
    }
    
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = dogCollection.dequeueReusableCell(withReuseIdentifier: "DogCell", for: indexPath) as? DogCell else { fatalError("dogCell not found") }
    guard let url = URL.init(string: myImages[indexPath.row]) else { return UICollectionViewCell() }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data {
            DispatchQueue.main.async {
                cell.dogImage.image = UIImage.init(data: data)
            }
        }
        }.resume()
    return cell
}
