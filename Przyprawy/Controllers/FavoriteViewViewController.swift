//
//  FavoriteViewViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 16/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import Contacts

class FavoriteViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var contact = ContactEntry()
//    var store = CNContactStore()
    var contactStore = CNContactStore()
    //var contacts = [ContactEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContacts()
        
        // Do any additional setup after loading the view.
    }
    @available (iOS 9.0, *)
    func getContacts() {
        let  store = CNContactStore()
        let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: "ku")
        
        //let xxx  = try store.unifiedContactsMatchingPredicate(CNContact.predicateForContactsMatchingName("ku"),
        //                                                                    keysToFetch:[CNContactGivenNameKey, CNContactFamilyNameKey])
        //let yyy = xxx.CNContact[0]
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        
        let contact: CNContact!
         //contact = contactList[indexPath.row]

        //cell.textLabel?.text = "\(contact.givenName) \(contact.familyName)"
        cell.textLabel?.text="AAAA"
        cell.detailTextLabel?.text="bbb"
        
        
        return cell
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
