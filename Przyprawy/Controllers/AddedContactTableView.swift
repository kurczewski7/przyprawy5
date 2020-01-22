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
        print("-----------")
        for (tmpKey, tmpContact) in Setup.preferedContacts {
            print("KKKKey name:\(tmpKey): \(tmpContact.name) \(tmpContact.phone) \(tmpContact.email)")
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

        if let pict = tmpContact.image  {
            cell.contactImage.image = pict //UIImage(data: pict)
            cell.contactImage.alpha = 1.0
        }
        else {
            cell.contactImage.image = UIImage(named: "user_male_full")
            cell.contactImage.alpha = 0.2
        }

        
        
        //cell.accessoryType = .checkmark
        return cell
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }


}
