//
//  AddPrizeViewController.swift
//  PrizeBook
//
//  Created by Oleksandr Oliinyk on 19.07.2021.
//

import UIKit

class AddPrizeViewController: UIViewController, StoryboardedProtocol {
    
    @IBOutlet weak var namePrizeAddTextField: UITextField!
    @IBOutlet weak var pricePrizeAddTextField: UITextField!
    @IBOutlet weak var informationLabel: UILabel!
    
    static let identifier = "AddPrizeViewController"
    static let storyboardName = "AddPrize"
    private let realmManager: DBManager = RealmManager()
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namePrizeAddTextField.delegate = self
        pricePrizeAddTextField.delegate = self
        informationLabel.isHidden = true
    }
    
    private func validPrice(price: String) -> Bool {
        let priceNumRegex = "^[0-9]+$"
        let trimmedString = price.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", priceNumRegex)
        let isValidPrice = validatePhone.evaluate(with: trimmedString)
        return isValidPrice
    }
    
    private func validName(name: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidName = validateName.evaluate(with: trimmedString)
        return isValidName
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
        let prizeToSave = PrizeModel(id: UUID().uuidString, name: namePrizeAddTextField.text ?? "" , price: Double(pricePrizeAddTextField.text ?? "") ?? 0.0, selected: false)
        if validName(name: namePrizeAddTextField.text ?? "") {
            if validPrice(price: pricePrizeAddTextField.text ?? "" ) {
                realmManager.save(prize: prizeToSave)
                showAlertResponse(message: "Prize was successfuly added. Do you want to continue?")
            } else {
                print("false in price")
                informationLabel.text = Localisation.failedPrice
                informationLabel.isHidden = false
            }
        } else {
            //Show alert fail and reason.
            print("false in name")
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
