//
//  ToShopTableViewCtr.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 09/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData

class ToShopTableViewCtr:   UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate {
    
   // UITableViewController, NSFetchedResultsControllerDelegate, UISearchBarDelegate
    let sectionNameKeyPath = "categoryId"
    let sortingKey = "categoryId"
    let entityName = "ToShopProductTable"
    
      enum SectionType: Int {
          case ToBuy = 0
          case AlreadyBought = 1
      }
      var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
      //@IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
          super.viewDidLoad()

          let context = database.context
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          let sort1 = NSSortDescriptor(key: sortingKey, ascending: true)
          //let sort2=NSSortDescriptor(key: "productName", ascending: true)
          fetchRequest.sortDescriptors = [sort1]
          fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                    managedObjectContext: context,
                                    sectionNameKeyPath: sectionNameKeyPath,
                                    cacheName: "SectionCache")
          fetchedResultsController.delegate =  self
          do {
              try fetchedResultsController.performFetch()
          } catch let error as NSError {
              print("Error: \(error.localizedDescription)")
              
          }
      }
      override func  viewWillAppear(_ animated: Bool) {
          print("Odświeżenie")
          do {
              try fetchedResultsController.performFetch()
          } catch let error as NSError {
              print("Error: \(error.localizedDescription)")
          }
          self.tableView?.reloadData()
          super.viewWillAppear(animated)
      }
      func numberOfSectionsInTableView
          (tableView: UITableView) -> Int {
          let sectionInfo =  fetchedResultsController.sections![0]
          
          print("======== numberOfSectionsInTableView:")
          print("ind: \(sectionInfo.indexTitle ?? "brak")")
          print("name: \(sectionInfo.name)")
          print("obj: \(sectionInfo.numberOfObjects)")
          print("count: \(sectionInfo.objects?.count ?? -1)")

          return fetchedResultsController.sections?.count ?? 1
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
          return fetchedResultsController.sections?[section].numberOfObjects ?? 0  //  sections?[section].count  ?? 0  //sectionInfo.numberOfObjects
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
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToShopTableViewCell
          let dlugosc = database.product.count
          print("dlugosc \(dlugosc) indexPath.row \(indexPath.row)")
        if let obj=fetchedResultsController.object(at: indexPath) as? ToShopProductTable {
            configureCell(cell: cell, withEntity: obj, at: indexPath)
          }
          return cell
      }
      func configureCell(cell: ToShopTableViewCell, withEntity toShopproduct: ToShopProductTable, at indexPath: IndexPath) {
          //row: Int, section: Int
          let row = indexPath.row
          let section = indexPath.section
          print("aaa\(row),\(section)")
        if  let product = toShopproduct.productRelation  {
              cell.detailLabel.text = ""
              cell.producentLabel.text = product.producent//"aaa\(row),\(section)"
              //cell.productNameLabel.text="cobj"
              cell.productNameLabel.text = product.productName
              cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
              cell.accessoryType = (toShopproduct.checked ? .checkmark : .none)
          }
          else
          {
              cell.accessoryType = (toShopproduct.checked ? .checkmark : .none)
              cell.detailLabel.text="No product"
          }
      }
      func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
          return true
      }
      func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
          print("Move ...items: Any..")
      }
      func saveDataAndReloadView() {
          do {
              try fetchedResultsController.managedObjectContext.save()
          }
          catch  {  print("Error saveing context \(error)")   }
          // tableView?.reloadData()
      }
      func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let action = UIContextualAction(style: .destructive, title: "Usuń z listy") { (lastAction, view, completionHandler) in
              print("Usuń z listy")
              
              
              let toShopProduct = self.fetchedResultsController.object(at: indexPath) as! ToShopProductTable
              self.fetchedResultsController.managedObjectContext.delete(toShopProduct)
              self.saveDataAndReloadView()
  //            toShopProduct.checked = true
  //            database.toShopProduct.toShopProductArray.remove(at: indexPath.row)
  //            database.save()
            //  self.tableView?.reloadData()
              completionHandler(true)
          }
          action.backgroundColor = .red
          action.image=UIImage(named: "full_trash")
          let swipe = UISwipeActionsConfiguration(actions: [action])
          return swipe
      }
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let sectionType = getSectionType(at: indexPath)
          let action1 = UIContextualAction(style: .destructive, title: "Kup") { (act, view, completionHandler) in
              print("Kup")
              let toShopProduct = self.fetchedResultsController.object(at: indexPath) as! ToShopProductTable
              toShopProduct.checked = true
              self.saveDataAndReloadView()
              completionHandler(true)
          }
          action1.backgroundColor =  #colorLiteral(red: 0.09233232588, green: 0.5611743331, blue: 0.3208354712, alpha: 1)
          action1.image =  UIImage(named: "buy_filled")
          
          let action2 = UIContextualAction(style: .destructive, title: "Zwróć") { (act, view, completionHandler) in
              print("Zwróć")
              let toShopProduct = self.fetchedResultsController.object(at: indexPath) as! ToShopProductTable
              toShopProduct.checked = false
              self.saveDataAndReloadView()
              completionHandler(true)
          }
          action2.backgroundColor =  #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
          action2.image =  UIImage(named: "return_purchase_filled")
          
          let swipe = UISwipeActionsConfiguration(actions: [sectionType == .ToBuy ?  action1 : action2])
          return swipe
      }
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          //var sectionType: SectionType = .ToBuy
          var headers = ["Do kupienia XX",  "Kupione YY","AAAA","BBBBB","CCCC","DDDD","EEEE","FFFF"]
        let colorList: [UIColor] = [.orange, .purple, .green, .blue, .brown, .cyan , .magenta, .purple]
          let label=UILabel()
        if let sectionCount = fetchedResultsController.sections?.count  {
            let indexPath = IndexPath(row: 0, section: section)
            let elem = fetchedResultsController.object(at: indexPath) as! ToShopProductTable
        }
            //              if elem.checked {
            //                  headers = ["Kupione"]
            //              }
            //              else {
            //                  headers = ["Do kupienia"]
            //              }
//          else {
//              headers = ["Do kupienia",  "Kupione"]
//          }
          
          
          let sectionName = headers[section]
          //let secCount = database.category.sectionsData[section].objects.count
          label.text="\(sectionName)"
          label.textAlignment = .center
          label.backgroundColor = colorList[section]
            //((section == 0) ?  #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1) : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))
        label.textColor = ((section % 2 == 0) ?  UIColor.black : UIColor.white)
          return label
      }
      func getSectionType(at indexPath: IndexPath) -> SectionType {
          let elem = fetchedResultsController.object(at: indexPath) as! ToShopProductTable
          return elem.checked ? SectionType.AlreadyBought : SectionType.ToBuy
      }
      func firstRunSetupSections(forEntityName entityName : String) {
      }

      func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
         
              print("Controler: old Indexpath \(indexPath), new Indexpath (\(newIndexPath)")
              self.tableView?.reloadData()
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
//-------------------------------------------

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


