//
//  Counter.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 20.07.2021.
//

import Foundation

protocol CounterProtocol {
    func increment(num: Double) -> Bool
    func decrement(num: Double)
    func balanceBasket(num: Double, currentIndex: Int)
}

struct CountBasket: CounterProtocol {
    
    private let realmManager: DBManagerProtocol = RealmManager()
    
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
