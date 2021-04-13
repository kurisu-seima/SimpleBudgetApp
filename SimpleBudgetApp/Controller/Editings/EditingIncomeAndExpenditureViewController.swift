//
//  EditingIncomeAndExpenditureViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/28.
//

import UIKit

class EditingIncomeAndExpenditureViewController: UIViewController {

    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var topLabel: UILabel!
    
    var incomeAndExpenditure: IncomeAndExpenditure!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsTextField.delegate = self
        amountTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupView()
    }
    
    @IBAction func doneButtonDidTapped(_ sender: Any) {
        guard let incomeAndExpenditure = incomeAndExpenditure, let details = detailsTextField.text, let amount = amountTextField.text, !details.isEmpty, !amount.isEmpty else {
            return
        }
        BudgetRepository.shared.write(someting: {
            incomeAndExpenditure.details = details
            incomeAndExpenditure.amountOfMoney = amount
        })
        BudgetRepository.shared.update(incomeAndExpenditure)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        detailsTextField.text = incomeAndExpenditure?.details
        amountTextField.text = incomeAndExpenditure?.amountOfMoney
        self.view.layer.insertSublayer(CAGradientLayer().mainLayer(frame: self.view.frame), at: 0)
        detailsTextField.backgroundColor = .clear
        amountTextField.backgroundColor = .clear
        guard let type = IncomeAndExpenditure.PlusOrMinus(rawValue: incomeAndExpenditure!.plusOrMinus) else {
            return
        }
        switch type {
        case .plus:
            topLabel.text = "臨時収入を編集できます"
        case .minus:
            topLabel.text = "臨時支出を編集できます"
        }
    }
}

extension EditingIncomeAndExpenditureViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
