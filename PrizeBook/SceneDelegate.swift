//
//  SceneDelegate.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?
    
    var realmManager: DBManagerProtocol = RealmManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        cleanBasket()
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.startMainPage()
        
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        
        appWindow.rootViewController = navController
        appWindow.makeKeyAndVisible()
        
        window = appWindow
    }
    
    private func cleanBasket() {
        SettingsKeys.counterInBasket = 0.0
        let prizesLocal = realmManager.obtainPrizes()
        prizesLocal.forEach { (prize) in
            realmManager.update(prize: prize, state: false)
        }
    }
}
