//
//  Counter.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 20.07.2021.
//

import Foundation

protocol Counter {
    <#requirements#>
}

struct CountBasket {
    
    private let realmManager: DBManager = RealmManager()
    
    func increment(num: Double) -> Bool {
        let local = SettingsKeys.counterInBasket + num
        if local <= 100.0 {
            SettingsKeys.counterInBasket += num
            return true
        } else {
            SettingsKeys.counterInBasket += num
            return false
        }
    }
    
    func decrement(num: Double) {
        SettingsKeys.counterInBasket -= num
    }
    
    func balanceBasket(num: Double, currentIndex: Int) {
        let prizesLocal = realmManager.obtainPrizes()
        var inc = 0
        while SettingsKeys.counterInBasket > 100 {
            guard inc != currentIndex, prizesLocal[inc].selected else { inc += 1; continue }
            let price = prizesLocal[inc].price
            let prize = prizesLocal[inc]
            realmManager.update(prize: prize, state: false)
            decrement(num: price)
            inc += 1
        }
    }
}
