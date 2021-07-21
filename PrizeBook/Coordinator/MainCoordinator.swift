//
//  MainCoordinator.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import Foundation
import UIKit

final class MainCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.overrideUserInterfaceStyle = .light
    }
    
    func startMainPage() {
        let vc = MainPageViewController.instantiateCustom(storyboard: MainPageViewController.storyboardName)
        vc.coordinator = self
        vc.title = "Prizes"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startAddPrizePage() {
        let vc = AddPrizeViewController.instantiateCustom(storyboard: AddPrizeViewController.storyboardName)
        vc.coordinator = self
        vc.title = "Add new prize"
        navigationController.pushViewController(vc, animated: true)
    }
}
