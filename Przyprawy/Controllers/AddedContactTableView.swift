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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           self.tableView.isEditing = true
        
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
            cell.contactImage.image = pict
            cell.contactImage.alpha = 1.0
            cell.contactImage.layer.cornerRadius=cell.contactImage.frame.size.width/2.0
            cell.contactImage.layer.masksToBounds = true

        }
        else {
            cell.contactImage.image = UIImage(named: "user_male_full")
            cell.contactImage.alpha = 0.2
        }

        //cell.accessoryType = .detailDisclosureButton
        //cell.s
        return cell
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let objectToMove = contactList[sourceIndexPath.row]
        contactList.remove(at: sourceIndexPath.row)
        contactList.insert(objectToMove, at: destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .green
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    //    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //        let movedObject = self.headlines[sourceIndexPath.row]
    //        headlines.remove(at: sourceIndexPath.row)
    //        headlines.insert(movedObject, at: destinationIndexPath.row)
    //    }

    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
}
