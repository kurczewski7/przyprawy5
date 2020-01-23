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
    
    var userKey: String?
    var isUserPicture: Bool = false
    
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
            newVal.image = isUserPicture ? contactImage.image : nil
//            if isUserPicture {
//                newVal.image = contactImage.image
//            } else
//            {
//                newVal.image = nil
//            }
            //newVal.image = UIImage(named: "user-male-icon")
            if let key = userKey {
                Setup.preferedContacts.updateValue(newVal, forKey: key)
            }
            //preferedContacts.
        }
        else {
            sender.tintColor = .red
            if let key = userKey {
                 Setup.preferedContacts.removeValue(forKey: key)
            }
        }
    }

//    get {
//        let centerX = origin.x + (size.width / 2)
//        let centerY = origin.y + (size.height / 2)
//        return Point(x: centerX, y: centerY)
//    }
//    set(newCenter) {
//        origin.x = newCenter.x - (size.width / 2)
//        origin.y = newCenter.y - (size.height / 2)
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
