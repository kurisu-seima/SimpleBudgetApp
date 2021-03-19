//
//  EditingFixedSavingsViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/18.
//

import UIKit

class EditingFixedSavingsViewController: UIViewController {

    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    var fixedSavings: FixedSavings?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldSetUp()
    }
    
    @IBAction func doneButtonDidTapped(_ sender: Any) {
        guard let fixedSavings = fixedSavings, let details = detailsTextField.text, let amount = amountTextField.text, !details.isEmpty, !amount.isEmpty else {
            return
        }
        BudgetRepository.shared.write(someting: {
            fixedSavings.details = details
            fixedSavings.amountOfMoney = amount
        })
        BudgetRepository.shared.update(fixedSavings)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func textFieldSetUp() {
        detailsTextField.text = fixedSavings?.details
        amountTextField.text = fixedSavings?.amountOfMoney
    }
}
