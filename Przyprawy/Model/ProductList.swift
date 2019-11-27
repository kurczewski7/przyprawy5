//
//  ProductList.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 31/10/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
class ProductList {
    init(pictureName name: String) {
        self.polishName=name
    }
    var englishName: String = ". List"
    var polishName: String = ". Lista"
    var pictureNane: String = ""
    var descripton : String = ""
    var isCheked: Bool = false
}
