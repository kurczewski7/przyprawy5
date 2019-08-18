//
//  SelProductViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 12/08/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData
class SelProductViewController: UIViewController, NSFetchedResultsControllerDelegate  {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension SelProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.toShopProduct.toShopProductArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelProductViewControllerCell //
        let toShop=database.toShopProduct.toShopProductArray
        let dlugosc = toShop.count
        print("dlugosc \(dlugosc) indexPath.row \(indexPath.row)")
        if let product = toShop[indexPath.row].productRelation {
            configureCell(cell: cell, withEntity: product, row: indexPath.row, section: indexPath.section )
        }
        return cell
    }
        //let tmp = database.product.productArray[indexPath.row < dlugosc  ? indexPath.row: 0]
        //let obj = fetchedResultsController.object(at: indexPath) as! ToShopProductTable
//        if let product=obj.productRelation {
//            configureCell(cell: cell, withEntity: product, row: indexPath.row, section: indexPath.section )
//        }
       
       
    func configureCell(cell: SelProductViewControllerCell, withEntity product: ProductTable, row: Int, section: Int) {
        cell.producentLabel.text=product.producent
        cell.productLabel.text=product.productName
        cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
        cell.detaliLabel.text=(product.weight>0 ? "\(product.weight)g" : "")
//        cell.detailLabel.text=product.description
//        cell.producentLabel.text="aaa\(row),\(section)"
//        //cell.productNameLabel.text="cobj"
//        cell.productNameLabel.text = product.productName
//        cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
    }

    
    
}
