//
//  UserDefaults.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 20.07.2021.
//

import Foundation

struct SettingsKeys {
    static var counterInBasket: Double {
        get {
            return UserDefaults.standard.double(forKey: "counterInBasket")
        } set {
            UserDefaults.standard.set(newValue, forKey: "counterInBasket")
        }
    }
}
