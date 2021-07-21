//
//  Validator.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 21.07.2021.
//

import Foundation

protocol ValidatorProtocol {
    func validPrice(price: String) -> Bool
    func validName(name: String) -> Bool
}

struct Validator: ValidatorProtocol {
    
     func validPrice(price: String) -> Bool {
        let priceNumRegex = "^[0-9]{0,3}$*((\\.|,)[0-9]{0,2})?$"
        let trimmedString = price.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", priceNumRegex)
        let isValidPrice = validatePhone.evaluate(with: trimmedString)
        return isValidPrice
    }
    
     func validName(name: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidName = validateName.evaluate(with: trimmedString)
        return isValidName
    }
}
