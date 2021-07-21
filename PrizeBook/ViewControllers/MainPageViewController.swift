//
//  ViewController.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

final class MainPageViewController: UIViewController, StoryboardedProtocol {
    
    @IBOutlet weak var prizesTableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    
    static let identifier = "MainPageViewController"
    static let storyboardName = "Main"
    weak var coordinator: MainCoordinator?
    
    private let realmManager: DBManagerProtocol = RealmManager()
    private let counter: CounterProtocol = CountBasket()
    private var prizes = [PrizeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAddPrizeButton()
        configurePrizesTableView()
        sumLabel.text = String(format: "%.2f",SettingsKeys.counterInBasket)
    }
    
    override func viewWillAppear(_ animated: Bool) { //To-Do: change to Callback.
        prizes = realmManager.obtainPrizes()
        prizesTableView.reloadData()
    }
    
    private func configurePrizesTableView() {
        prizesTableView.delegate = self
        prizesTableView.dataSource = self
        prizesTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: PrizeTableViewCell.identifier)
        prizesTableView.backgroundColor = UIColor(red: 0.953, green: 0.984, blue: 1, alpha: 1)
    }
    
    private func showAlertResponse(priceToDecrement: Double, index: Int) {
        let alert = UIAlertController(title: "Sorry", message: "Basket price is over the limit (100$). Removed first (or few) of your choice.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            
            self.counter.balanceBasket(num: priceToDecrement, currentIndex: index)
            self.prizesTableView.reloadData()
            self.sumLabel.text = String(format: "%.2f",SettingsKeys.counterInBasket)

        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func createAddPrizeButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        coordinator?.startAddPrizePage()
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prize = prizes[indexPath.row]
        if !prize.selected {
            if !counter.increment(num: prize.price) {
                showAlertResponse(priceToDecrement: prize.price, index: indexPath.row)
            }
            realmManager.update(prize: prize, state: true)
        } else {
            realmManager.update(prize: prize, state: false)
            counter.decrement(num: prize.price)
        }
        
        sumLabel.text = String(format: "%.2f",SettingsKeys.counterInBasket)
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
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let prize = prizes[indexPath.row]
            let index = indexPath.row
            let priceToDecrement = prizes[index].price
            
            realmManager.delete(prize: prize)
            prizes.remove(at: index)
            
            changeBasketValue(value: priceToDecrement)
            tableView.reloadData()
        }
    }
    
    private func changeBasketValue(value: Double) {
        let current = SettingsKeys.counterInBasket - value
        if current <= 0.0 {
            SettingsKeys.counterInBasket = 0.0
            sumLabel.text = String(format: "%.2f",SettingsKeys.counterInBasket)
        } else {
            counter.decrement(num: value)
            sumLabel.text = String(format: "%.2f",SettingsKeys.counterInBasket)
        }
    }
}
