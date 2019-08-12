//
//  SelProductViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 12/08/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData
protocol ProductProtocol {
    var producentName: String {get set}
    var productName: String {get set}
    var picture: UIImage? {get set}
}
class SelProductViewController: UIViewController, NSFetchedResultsControllerDelegate, ProductProtocol  {
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    override func viewDidLoad() {
        super.viewDidLoad()
        // categoryId   productName
        
        let context = database.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductTable")
        let sort1 = NSSortDescriptor(key: "categoryId", ascending: true)
        let sort2=NSSortDescriptor(key: "productName", ascending: true)
        fetchRequest.sortDescriptors = [sort1, sort2]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: "categoryId",
                                                              cacheName: "SectionCache")
        fetchedResultsController.delegate =  self
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    var picture: UIImage?=nil
    var producentName: String = ""
    var productName: String = ""
}
extension SelProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InBasketTableViewCell //
        let dlugosc = database.product.productArray.count
        print("dlugosc \(dlugosc) indexPath.row \(indexPath.row)")
        //let tmp = database.product.productArray[indexPath.row < dlugosc  ? indexPath.row: 0]
        let obj = fetchedResultsController.object(at: indexPath) as! ProductTable
        configureCell(cell: cell, withEntity: obj, row: indexPath.row, section: indexPath.section )
        return cell
    }
    func configureCell(cell: InBasketTableViewCell, withEntity product: ProductTable, row: Int, section: Int) {
        cell.detailLabel.text=product.description
        cell.producentLabel.text="aaa\(row),\(section)"
        //cell.productNameLabel.text="cobj"
        cell.productNameLabel.text = product.productName
        cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
    }

    
    
}
