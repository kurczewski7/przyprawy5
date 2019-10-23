//
//  SelectedProducyListController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 06/10/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import Foundation

class SelectedProducyListController: UIViewController {
    let items: [String] = ["1","2","3","4","5","6","7","8","9"]
    
    let picturesName: [String] = ["zakupy.jpg","tort2.jpeg","dom1.jpeg","ogrod2.jpeg","zwierzeta4.jpg","zwierzeta3.jpg","tort2.jpg","tort2.jpeg","tort2.jpeg"]
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CFloat = 3
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
extension SelectedProducyListController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! SelectedProductListCell
        cell.listLabel.text=items[indexPath.row]
        // cell.picture.image = UIImage(named: picturesName[indexPath.row]) ?? UIImage(named: "agd.jpg")
        cell.backgroundColor = .yellow
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat =  CGFloat(itemsPerRow + 1) * CGFloat(sectionInsets.left)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = CGFloat(availableWidth / CGFloat(itemsPerRow))
        //return CGSize(width: widthPerItem, height: widthPerItem)
        return CGSize(width: 250, height: 250)
        
        
    }
}