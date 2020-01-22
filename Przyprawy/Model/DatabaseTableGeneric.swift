//
//  DatabaseTableGeneric.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 22/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import CoreData
// New Class ------------------------------------------
// variable for ProductTable
class DatabaseTableGeneric: DatabaseTableProtocol {

    var context: NSManagedObjectContext
    private var  productArray: [ProductTable] = []
    private var  productArrayFiltered: [ProductTable] = []
    
    var featchResultCtrl: NSFetchedResultsController<ProductTable>
    let feachRequest: NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
    var sortDescriptor:NSSortDescriptor
    var count: Int {
        get {   return productArray.count   }
    }
    var array: [ProductTable] {
        get {   return productArray   }
        set {   productArray = newValue  }
    }
    var arrayFiltered:[ProductTable] {
        get {   return productArrayFiltered   }
        set {   productArrayFiltered = newValue  }
    }
    subscript(index: Int) -> ProductTable {
        get {  return productArray[index]      }
        set {  productArray[index] = newValue  }
    }
//    subscript(section: Int, row: Int) {
//        get { return nil }
//        set { _ = newValue }
//    }
    func append<T>(_ value: T) {
        if let val = value as? ProductTable {
            productArray.append(val)
        }
    }
    init(context: NSManagedObjectContext)
    {
        self.context=context
        productArray=[]
        sortDescriptor=NSSortDescriptor(key: "productName", ascending: true)
        feachRequest.sortDescriptors = [sortDescriptor]
        featchResultCtrl=NSFetchedResultsController(fetchRequest: feachRequest, managedObjectContext:  context, sectionNameKeyPath: nil, cacheName: nil)
    }
    func add(value: ProductTable) -> Int {
        productArray.append(value)
        return productArray.count
    }
    func remove(at row: Int) -> Bool {
        let res: Bool
        if row < productArray.count {
            productArray.remove(at: row)
            res = true
        }
        else {
            res = false
        }
        return res
    }
    func remove(fromDatabaseRow row:Int) -> Bool {
        
        return true
    }
    
} // end of class ProductSeting
