//
//  AddPrizeViewController.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

final class AddPrizeViewController: UIViewController, StoryboardedProtocol {
    
    @IBOutlet weak var namePrizeAddTextField: UITextField!
    @IBOutlet weak var pricePrizeAddTextField: UITextField!
    @IBOutlet weak var informationLabel: UILabel!
    
    static let identifier = "AddPrizeViewController"
    static let storyboardName = "AddPrize"
    weak var coordinator: MainCoordinator?
    
    private let realmManager: DBManagerProtocol = RealmManager()
    private let validatorManager: ValidatorProtocol = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namePrizeAddTextField.delegate = self
        pricePrizeAddTextField.delegate = self
        informationLabel.isHidden = true
    }
    
    private func showAlertResponse(message: String?) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.namePrizeAddTextField.text = ""
            self.pricePrizeAddTextField.text = ""
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func savePrizeTapped(_ sender: UIButton) {
        informationLabel.isHidden = true
        let name = namePrizeAddTextField.text ?? ""
        let price = Double(pricePrizeAddTextField.text ?? "") ?? 0.0
        let prizeToSave = PrizeModel(id: UUID().uuidString, name: name , price: price, selected: false)
        
        if validatorManager.validName(name: name) {
            if validatorManager.validPrice(price: String(price)) {
                realmManager.save(prize: prizeToSave)
                showAlertResponse(message: "Prize was successfuly added. Do you want to continue?")
            } else {
                informationLabel.text = Localisation.failedPrice
                informationLabel.isHidden = false
            }
        } else {
            informationLabel.text = Localisation.failedName
            informationLabel.isHidden = false
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddPrizeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        namePrizeAddTextField.resignFirstResponder()
        pricePrizeAddTextField.resignFirstResponder()
        
        return true
    }
}
