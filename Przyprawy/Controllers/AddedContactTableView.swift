//
//  AddedContactTableViewCell.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 20/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class AddedContactTableView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var contactList: [Setup.SelectedContact] = []
    override func viewDidLoad() {
        for tmpContact in Setup.preferedContacts.values {
            print("Airport name: \(tmpContact.name)")
            self.contactList.append(tmpContact)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell=UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! AddedContactTableViewCell
        let tmpContact = contactList[indexPath.row]
        cell.contactNameLabel.text = tmpContact.name
        cell.contactPhoneNumberLabel.text = tmpContact.phone
        cell.eMailLabel.text = tmpContact.email
        
        //cell.accessoryType = .checkmark
        return cell
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }


}
