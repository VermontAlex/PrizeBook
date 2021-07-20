//
//  ViewController.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

class MainPageViewController: UIViewController, StoryboardedProtocol {
    
    @IBOutlet weak var prizesTableView: UITableView!
    @IBOutlet weak var summLabel: UILabel!
    
    
    static let identifier = "MainPageViewController"
    static let storyboardName = "Main"
    weak var coordinator: MainCoordinator?
    
    private let realmManager: DBManager = RealmManager()
    private var prizes = [PrizeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAddPrizeButton()
        configurePrizesTableView()
        SettingsKeys.counterInBasket = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) { //Should change to Callback.
        prizes = realmManager.obtainPrizes()
        prizesTableView.reloadData()
    }
    
    private func configurePrizesTableView() {
        prizesTableView.delegate = self
        prizesTableView.dataSource = self
        prizesTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: PrizeTableViewCell.identifier)
    }
    
    private func createAddPrizeButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        coordinator?.startAddPrizePage(storyboardName: AddPrizeViewController.storyboardName)
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prize = prizes[indexPath.row]
        if prize.selected == false {
            realmManager.update(prize: prize, state: true)
            let count = prize.price
           SettingsKeys.counterInBasket += count
            summLabel.text = String(SettingsKeys.counterInBasket)
        } else {
            realmManager.update(prize: prize, state: false)
            let count = prize.price
            SettingsKeys.counterInBasket -= count
             summLabel.text = String(SettingsKeys.counterInBasket)
        }
        prizesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrizeTableViewCell.identifier, for: indexPath) as! PrizeTableViewCell
        
        cell.fillCell(prize: prizes[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realmManager.delete(prize: prizes[indexPath.row])
            prizes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
