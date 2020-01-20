//
//  FavoriteContactTableViewCell.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 17/01/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class FavoriteContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactNameLabel: UILabel!
    
    @IBOutlet weak var contactPhoneNumberLabel: UILabel!
    
    @IBOutlet weak var eMailLabel: UILabel!
    
    
    @IBOutlet weak var iLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func iLikeTap(_ sender: UIButton) {
        if sender.tintColor == .red {
            sender.tintColor = .green
            let name = contactNameLabel.text ?? ""
            let email = eMailLabel.text ?? ""
            let pfone = contactPhoneNumberLabel.text ?? ""
            var newVal =  Setup.SelectedContact(name: name, email: email, phone: pfone)
            newVal.image = UIImage(named: "user-male-icon")
            if let key=Setup.currentContactKey {
                Setup.preferedContacts.updateValue(newVal, forKey: key)
            }
            //preferedContacts.
        }
        else {
            sender.tintColor = .red
            if let key=Setup.currentContactKey {
                 Setup.preferedContacts.removeValue(forKey: key)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
