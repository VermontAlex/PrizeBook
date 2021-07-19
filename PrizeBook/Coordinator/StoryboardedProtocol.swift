//
//  StoryboardedProtocol.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import Foundation
import UIKit

protocol StoryboardedProtocol {
    static func instantiateCustom(storyboard: String) -> Self
}

extension StoryboardedProtocol where Self: UIViewController {
    static func instantiateCustom(storyboard: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
