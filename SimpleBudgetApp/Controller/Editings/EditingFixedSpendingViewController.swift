//
//  EditingFixedSpendingViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/18.
//

import UIKit

class EditingFixedSpendingViewController: UIViewController {

    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    var fixedSpending: FixedSpending?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func doneButtonDidTapped(_ sender: Any) {
        guard let fixedSpending = fixedSpending, let details = detailsTextField.text, let amount = amountTextField.text, !details.isEmpty, !amount.isEmpty else {
            return
        }
        BudgetRepository.shared.write(someting: {
            fixedSpending.details = details
            fixedSpending.amountOfMoney = amount
        })
        BudgetRepository.shared.update(fixedSpending)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        self.overrideUserInterfaceStyle = .light
        detailsTextField.text = fixedSpending?.details
        amountTextField.text = fixedSpending?.amountOfMoney
        self.view.layer.insertSublayer(CAGradientLayer().fixedSpendingVCLayer(frame: self.view.frame), at: 0)
        detailsTextField.backgroundColor = UIColor.clear
        amountTextField.backgroundColor = UIColor.clear
    }
}
