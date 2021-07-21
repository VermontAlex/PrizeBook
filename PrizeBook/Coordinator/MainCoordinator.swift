//
//  MainCoordinator.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import Foundation
import UIKit

class MainCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.overrideUserInterfaceStyle = .light
    }
    
    func startMainPage(storyboardName: String) {
        let vc = MainPageViewController.instantiateCustom(storyboard: storyboardName)
        vc.coordinator = self
        vc.title = "Prizes"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startAddPrizePage(storyboardName: String) {
        let vc = AddPrizeViewController.instantiateCustom(storyboard: storyboardName)
        vc.coordinator = self
        vc.title = "Add new prize"
        navigationController.pushViewController(vc, animated: true)
    }
}
