//
//  PrizeModel.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import Foundation
import RealmSwift

@objcMembers
class PrizeModel: Object {
    
    dynamic var id = String()
    dynamic var name = String()
    dynamic var price = 0.0
    dynamic var selected = false
    
    convenience init(id: String,name: String, price: Double, selected: Bool) {
        self.init()
        self.name = name
        self.price = price
        self.id = id
        self.selected = selected
    }
}
