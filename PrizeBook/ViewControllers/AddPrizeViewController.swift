//
//  AddPrizeViewController.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

class AddPrizeViewController: UIViewController, StoryboardedProtocol {

    static let identifier = "AddPrizeViewController"
    static let storyboardName = "AddPrize"
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
