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
    
    dynamic var name = String()
    dynamic var price = 0
    
}
