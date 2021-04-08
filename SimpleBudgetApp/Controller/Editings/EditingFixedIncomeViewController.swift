//
//  EditingFixedIncomeViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/18.
//

import UIKit

class EditingFixedIncomeViewController: UIViewController {

    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    var fixedIncome: FixedIncome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func doneButtonDidTapped(_ sender: Any) {
        guard let fixedIncome = fixedIncome, let details = detailsTextField.text, let amount = amountTextField.text, !details.isEmpty, !amount.isEmpty else {
            return
        }
        BudgetRepository.shared.write(someting: {
            fixedIncome.details = details
            fixedIncome.amountOfMoney = amount
        })
        BudgetRepository.shared.update(fixedIncome)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        detailsTextField.text = fixedIncome?.details
        amountTextField.text = fixedIncome?.amountOfMoney
        self.view.layer.insertSublayer(CAGradientLayer().fixedIncomeVCLayer(frame: self.view.frame), at: 0)
        detailsTextField.backgroundColor = UIColor.clear
        amountTextField.backgroundColor = UIColor.clear
    }
}
