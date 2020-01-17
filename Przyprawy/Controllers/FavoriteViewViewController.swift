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
    var contacts: [CNContact] = []
    var store = CNContactStore()
    struct FavoriteContact {
        let name: String = "Name"
    }
    var contactStore = CNContactStore()
    //var contacts = [ContactEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContacts()
        
        // Do any additional setup after loading the view.
    }
    @available (iOS 9.0, *)
    func getContacts() {
        isAccesToContact { (success) in
            self.retriveContacts()
        }
        
        //let  store = CNContactStore()
        //let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: "ku")
        
        //let xxx  = try store.unifiedContactsMatchingPredicate(CNContact.predicateForContactsMatchingName("ku"),
        //                                                                    keysToFetch:[CNContactGivenNameKey, CNContactFamilyNameKey])
        //let yyy = xxx.CNContact[0]
        
    }
    func isAccesToContact(_ completion: @escaping (_ success: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .authorized:
            completion(true)
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: .contacts) { (accessGranted, error) in
                completion(accessGranted)
            }
        default:
                completion(false)
         }
    }
    func retriveContacts() {
        let keys  = [CNContactGivenNameKey, CNContactFamilyNameKey,CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            //var favoritContacts = [FavoriteContact]()
            try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                print("Osoba:")
                print(contact.givenName)
                print(contact.familyName)
                print(contact.phoneNumbers.first?.value.stringValue ?? "brak tel")
                self.contacts.append(contact)
            })
           // let names = ExpandableNames()
        } catch let err {
                print("Failed to enumerate contacts", err)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        
        let contact: CNContact!
         //contact = contactList[indexPath.row]

        //cell.textLabel?.text = "\(contact.givenName) \(contact.familyName)"
        cell.textLabel?.text = contacts[indexPath.row].familyName
        cell.detailTextLabel?.text = contacts[indexPath.row].givenName
        
        
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
