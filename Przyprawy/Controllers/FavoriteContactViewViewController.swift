//
//  FavoriteViewViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 16/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import Contacts

class FavoriteContactViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        //let cell = UITableViewCell()
        //cell.textLabel?.text="AAA:\(indexPath.row)"
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! FavoriteContactTableViewCell

        //let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteContactTableViewCell
        //let contact: CNContact!
        let email = "email"
        let cont: CNContact = contacts[indexPath.row] as CNContact
    
        let phoneNumber = cont.phoneNumbers.first?.value.stringValue ?? "brak tel"
        cell.contactPhoneNumberLabel.text = phoneNumber
        cell.contactNameLabel.text = "\(cont.familyName) \(cont.givenName)  \(email)"

        cell.contactImage.image = UIImage(named: "user_male_full")
        cell.contactImage.layer.cornerRadius=cell.contactImage.frame.size.width/2.0
        cell.contactImage.layer.masksToBounds = true
        if (indexPath.row % 3) == 0 {
            
            cell.contactImage.alpha = 0.2
        }
        else {
            cell.contactImage.tintColor = .systemBlue
        }
//        if let imAvail = cont.imageDataAvailable {
//            print("imageDataAvailable:\(imAvail)")
//        }
        
       // print("contact:\(phoneNumber),\(cont.imageDataAvailable)")
        
        
        
//        if let pict = cont.imageData  {
//            // let uimag = UIImage(data: pict)
//            print("IMG ok")
//            //cell.contactImage.image = UIImage(data: pict)
//        }
//        else {
//            print("Bład IMG")
//        }
        
        //cell.iLikeImige.image = UIImage(named: "add_favorites_filled")
        //let name = "\(cont.givenName) \(cont.familyName)"
        //cont.emailAddresses.first?.value.substring(from: 0) ?? "no email"
        //cell.contactNameLabel.text = cont.familyName
        //= "\(cont.givenName) \(contact.familyName)"
        //cell.textLabel?.text = "\(cont.familyName) \(cont.givenName) \(phoneNumber) \(email)"
        //cell.detailTextLabel?.text = "bbb" //contacts[indexPath.row].givenName
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
