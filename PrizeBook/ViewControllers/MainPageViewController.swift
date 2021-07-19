//
//  ViewController.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

class MainPageViewController: UIViewController, StoryboardedProtocol {
    
    static let identifier = "MainPageViewController"
    static let storyboardName = "Main"
    weak var coordinator: MainCoordinator?
    
    private let realmManager: DBManager = RealmManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        createAddPrizeButton()
    }
    
    func createAddPrizeButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        coordinator?.startAddPrizePage(storyboardName: AddPrizeViewController.storyboardName)
    }
}
