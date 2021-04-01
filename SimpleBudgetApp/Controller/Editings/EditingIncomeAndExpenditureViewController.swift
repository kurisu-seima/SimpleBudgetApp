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
    
    var incomeAndExpenditure: IncomeAndExpenditure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}
