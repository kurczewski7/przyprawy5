//
//  SelectedProducyListController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 06/10/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class SelectedProducyListController: UIViewController {
    let items: [String] = ["1","2","3","4","5","6","7","8","9"]
    
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
extension SelectedProducyListController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! SelectedProductListCell
        cell.listLabel.text=items[indexPath.row]
        cell.picture.image=UIImage(named: "cameraCanon")
        cell.backgroundColor = .yellow
        
        return cell
    }    
}
