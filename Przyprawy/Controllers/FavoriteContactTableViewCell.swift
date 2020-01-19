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
    
    @IBOutlet weak var iLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func iLikeTap(_ sender: UIButton) {
        sender.tintColor = UIColor.green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
