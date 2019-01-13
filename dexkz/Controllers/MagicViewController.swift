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


