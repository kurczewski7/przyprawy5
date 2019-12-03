//
//  SelectedProducyListController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 06/10/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import Foundation

class SelectedProducyListController: UIViewController, SelectedProductListDelegate  {
    var selectProd: SelectedProductListDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items: [String] = ["1","2","3","4","5","6","7","8","9"]
    let picturesName: [String] = ["zakupy.jpg","tort2.jpeg","dom1.jpeg","ogrod2.jpeg","zwierzeta4.jpg","zwierzeta3.jpg","mieso.jpg","warzywa.jpg","przyprawa.jpg","napoje.jpg","napoje2.jpg","leki.jpg","agd.jpg","tree.jpg"]
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CFloat = 3
    private var cards: [ProductList] = []
    
    func fillCards() {
        for elem in picturesName {
            cards.append(ProductList(pictureName: elem))
        }
       
    }
    // MARK: SelectedProductListDelegate method
    func didListChoicePressed(cell: UICollectionViewCell) {
        
        if let indexPath=collectionView.indexPath(for: cell) {
            cell.isSelected = !cell.isSelected
            print("cell:\(indexPath.item),\(indexPath.row)")
        }
    }
}
extension SelectedProducyListController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    // MARK: UICollectionViewDelegate method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        picturesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! SelectedProductListCell
        cell.listLabel.text="\(indexPath.row+1). Lista"
        cell.picture.image = UIImage(named: picturesName[indexPath.row]) ?? UIImage(named: "agd.jpg")
        cell.backgroundColor = .yellow
        cell.delegate = self
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
