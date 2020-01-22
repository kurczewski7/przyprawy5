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
class DatabaseTableGeneric <P: NSFetchRequestResult> { 

    var context: NSManagedObjectContext
    private var  genericArray = [P]()
    private var  genericArrayFiltered: [P] = []
    
    var featchResultCtrl: NSFetchedResultsController<P> = NSFetchedResultsController<P>()
    var feachRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
    var sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor]()
    var count: Int {
        get {   return genericArray.count   }
    }
    var array: [P] {
        get {   return genericArray   }
        set {   genericArray = newValue  }
    }
    var arrayFiltered:[P] {
        get {   return genericArrayFiltered   }
        set {   genericArrayFiltered = newValue  }
    }
    subscript(index: Int) -> P {
        get {  return genericArray[index]      }
        set {  genericArray[index] = newValue  }
    }
//    subscript(section: Int, row: Int) {
//        get { return nil }
//        set { _ = newValue }
//    }
    func append<T>(_ value: T) {
        if let val = value as? P {
            genericArray.append(val)
        }
    }
    init(context: NSManagedObjectContext, keys: [String], ascendingKeys: [Bool], _ setFetchReqest: () -> NSFetchRequest<NSFetchRequestResult>) {
        self.context=context
        genericArray=[]
        feachRequest = setFetchReqest()
        //feachRequest = initalizeFeachRequest()     // ProductTable.fetchRequest()
        for i in 0..<keys.count {
            sortDescriptors.append(NSSortDescriptor(key: keys[i], ascending: ascendingKeys[i]))
        }
        feachRequest.sortDescriptors = sortDescriptors
        featchResultCtrl = NSFetchedResultsController(fetchRequest: feachRequest, managedObjectContext:  context, sectionNameKeyPath: nil, cacheName: nil) as! NSFetchedResultsController<P>
    }
    func add(value: P) -> Int {
        genericArray.append(value)
        return genericArray.count
    }
    func remove(at row: Int) -> Bool {
        let res: Bool
        if row < genericArray.count {
            genericArray.remove(at: row)
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
