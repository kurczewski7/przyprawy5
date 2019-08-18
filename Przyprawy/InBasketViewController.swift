//
//  InBasketViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 18/01/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData

class InBasketViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    override func viewDidLoad() {
        super.viewDidLoad()
        // categoryId   productName
        
        let context = database.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToShopProductTable")
        let sort1 = NSSortDescriptor(key: "changeDate", ascending: true)
        //let sort2=NSSortDescriptor(key: "productName", ascending: true)
        fetchRequest.sortDescriptors = [sort1]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: "changeDate", //"changeDate", checked
                                                              cacheName: "SectionCache")
        fetchedResultsController.delegate =  self
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    func numberOfSectionsInTableView
        (tableView: UITableView) -> Int {
        let sectionInfo =  fetchedResultsController.sections![0]
        
        print("ind: \(sectionInfo.indexTitle ?? "brak")")
        print("name: \(sectionInfo.name)")
        print("obj: \(sectionInfo.numberOfObjects)")
        print("count: \(sectionInfo.objects?.count ?? -1)")

        return fetchedResultsController.sections!.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let sectionInfo =
            fetchedResultsController.sections![section]
        
        return sectionInfo.name
    }
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
       // let sectionInfo = fetchedResultsController.sections![section]
//            print("numb: \(sectionInfo.numberOfObjects)")
//            print("index: \(sectionInfo.indexTitle)")
//            print("name: \(sectionInfo.name)")
//            print("count: \(sectionInfo.objects?.count)")
        return fetchedResultsController.sections?.count  ?? 0  //sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = fetchedResultsController.sections?.count
        return sectionCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InBasketTableViewCell
        let dlugosc = database.product.productArray.count
        print("dlugosc \(dlugosc) indexPath.row \(indexPath.row)")
        //let tmp = database.product.productArray[indexPath.row < dlugosc  ? indexPath.row: 0]
        let obj=fetchedResultsController.object(at: indexPath) as! ToShopProductTable
        if let product = obj.productRelation {
            configureCell(cell: cell, withEntity: product, row: indexPath.row, section: indexPath.section )
        }
        return cell
    }
    func configureCell(cell: InBasketTableViewCell, withEntity product: ProductTable, row: Int, section: Int) {
        cell.detailLabel.text=product.description
        cell.producentLabel.text="aaa\(row),\(section)"
        //cell.productNameLabel.text="cobj"
        cell.productNameLabel.text = product.productName
        cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Move ...items: Any..")
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Usuń z listy") { (lastAction, view, completionHandler) in
            //let sectionInfo =  self.fetchedResultsController.sections![indexPath.section]
            //sectionInfo.objects?.remove(at: indexPath.row)
            print("Usuń z listy")
            database.toShopProduct.toShopProductArray.remove(at: indexPath.row)
            database.save()
            completionHandler(true)
        }
        action.backgroundColor = .red
        action.image=UIImage(named: "full_trash")
        let swipe = UISwipeActionsConfiguration(actions: [action])
        return swipe
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(style: .destructive, title: "Kup") { (act, view, completionHandler) in
            print("Kup")
            database.toShopProduct.toShopProductArray[indexPath.row].checked = true
            database.save()
          completionHandler(true)
        }
        action1.backgroundColor =  #colorLiteral(red: 0.09233232588, green: 0.5611743331, blue: 0.3208354712, alpha: 1)
        action1.image =  UIImage(named: "buy_filled")
        action1.title = "Kup"
        
        let action2 = UIContextualAction(style: .destructive, title: "Kup") { (act, view, completionHandler) in
            print("Kup")
            database.toShopProduct.toShopProductArray[indexPath.row].checked = false
            database.save()
            completionHandler(true)
        }
        action2.backgroundColor =  #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        action2.image =  UIImage(named: "return_purchase_filled")
        action2.title = "Zwróć"
        let swipe = UISwipeActionsConfiguration(actions: [indexPath.section==0 ?  action1 : action2])
        return swipe
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headers = ["Do kupienia",  "Kupione", "sec AAA", "Sec BBB", "Sec CCC","Sec DDDD"]
        let label=UILabel()
        let sectionName = headers[section]
        //let secCount = database.category.sectionsData[section].objects.count
        label.text="\(sectionName)"
        label.textAlignment = .center
        label.backgroundColor = ((section == 0) ?  #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1) : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))
        label.textColor = ((section != 0) ? UIColor.white : UIColor.black)
        return label
    }
    func firstRunSetupSections(forEntityName entityName : String) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
