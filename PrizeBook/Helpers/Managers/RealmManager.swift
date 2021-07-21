//
//  RealmManager.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import Foundation
import RealmSwift

protocol DBManagerProtocol {
    func save(prize: PrizeModel)
    func obtainPrizes() -> [PrizeModel]
    func delete(prize: PrizeModel)
    func update(prize: PrizeModel, state: Bool) 
}

final class RealmManager: DBManagerProtocol {
    
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)
    
    func save(prize: PrizeModel) {
        do {
            try mainRealm.write {
                mainRealm.add(prize)
            }
        } catch {
            print(error)
        }
    }
    
    func update(prize: PrizeModel, state: Bool) {
        do {
            try mainRealm.write {
                prize.selected = state
            }
        } catch {
            print(error)
        }
    }
    
    func obtainPrizes() -> [PrizeModel] {
        let models = mainRealm.objects(PrizeModel.self)
        
        return Array(models)
    }
    
    func delete(prize: PrizeModel) {
        do {
            try mainRealm.write {
                mainRealm.delete(prize)
            }
        } catch {
            print(error)
        }
    }
}
