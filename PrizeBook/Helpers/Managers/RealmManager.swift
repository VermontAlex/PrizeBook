//
//  RealmManager.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import Foundation
import RealmSwift

protocol DBManager {
    func save(prize: PrizeModel)
    func obtainPrizes() -> [PrizeModel]
    func delete(prize: PrizeModel)
    func update(prize: PrizeModel, state: Bool) 
}

class RealmManager: DBManager {
    
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)
    
    func save(prize: PrizeModel) {
        try? mainRealm.write {
            mainRealm.add(prize)
        }
    }
    
    func update(prize: PrizeModel, state: Bool) {
        try! mainRealm.write {
            prize.selected = state
        }

    }
    
    func obtainPrizes() -> [PrizeModel] {
        let models = mainRealm.objects(PrizeModel.self)
        
        return Array(models)
    }
    
    func delete(prize: PrizeModel) {
        try? mainRealm.write {
            mainRealm.delete(prize)
        }
    }
}
