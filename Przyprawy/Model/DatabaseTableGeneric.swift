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
    private var  currentRow = 0
    
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
        get {  _ = isIndexInRange(index: index)
            return genericArray[index]      }
        set {   _ = isIndexInRange(index: index)
            genericArray[index] = newValue  }
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
    func isIndexInRange(index: Int) -> Bool {
            if index >= count {
                print("Index \(index) is bigger then count \(count). Give correct index!")
                return false
            }
            else {
                return true
            }
        }
    //    subscript(section: Int, row: Int) {
    //        get { return nil }
    //        set { _ = newValue }
    //    }
    func first() -> P {
        _ = isIndexInRange(index: 0)
        return genericArray[0]
    }
    func last() -> P {
        let lastVal = count-1
        _ = isIndexInRange(index: lastVal)
        return genericArray[lastVal]

    }
    func append<T>(_ value: T) {
        if let val = value as? P {
            genericArray.append(val)
        }
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
    func deleteAll()  {
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: feachRequest)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    func next() -> P? {
        if currentRow+1 < count {
            currentRow += 1
            return genericArray[currentRow]
        }
        else {
            return nil
        }
        
    }
    func previous() -> P? {
        if currentRow > 0 && currentRow < count {
            currentRow += 1
            return genericArray[currentRow]
        }
        else {
            return nil
        }
    }

    
//    func removeAll() {
//        genericArray.removeAll()
//    }
//    func deleteAll() {
//        removeAll()
//    }
    
} // end of class ProductSeting
