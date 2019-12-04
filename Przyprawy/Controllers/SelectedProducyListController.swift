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

    var currentCheckList = 0
    let itemsPerRow: CFloat = 3
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  
    override func viewDidLoad() {
    
    }
    // MARK: SelectedProductListDelegate method
    func didListChoicePressed(cell: SelectedProductListCell) {
        if let indexPath=collectionView.indexPath(for: cell) {
            currentCheckList = indexPath.item
            //cards[indexPath.item].isCheked = !cards[indexPath.item].isCheked
            cell.isChecked =  true //cards[indexPath.item].isCheked
            print("cell:\(indexPath.item),\(indexPath.row)")
        }
    }
}
extension SelectedProducyListController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    // MARK: UICollectionViewDelegate method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count // picturesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! SelectedProductListCell
        cell.listLabel.text="\(indexPath.row+1). \(cards[indexPath.item].getName())"
        cell.picture.image = UIImage(named: cards[indexPath.item].pictureName) ?? UIImage(named: "agd.jpg")
        cell.isChecked = (indexPath.item == currentCheckList)
    
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
