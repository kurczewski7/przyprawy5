//
//  SelectedProductListCell.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 06/10/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
protocol SelectedProductListDelegate {
    func didListChoicePressed(cell: SelectedProductListCell)
}
class SelectedProductListCell: UICollectionViewCell    {
    var delegate: SelectedProductListDelegate?
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var listLabel: UILabel!
    @IBOutlet var iChoicePicture: UIButton!
    @IBAction func ListChoiceButtonPressed(_ sender: UIButton) {
        print("ListChoiceButtonPressed")
        delegate?.didListChoicePressed(cell: self)
    }
var isChecked: Bool = false {
    didSet {
        if isChecked {
            print("isChecked On")
            iChoicePicture.setImage(UIImage(named: "heartfull"), for: .normal)
        }
        else {
             print("isChecked Off")
            iChoicePicture.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }
}

// Protocool
