//
//  CustomView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/20.
//

import UIKit

protocol CustomViewDelegate {
    var addButtonTagCount: Int { get }
    func closeInputView()
}

class CustomView: UIView {
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var amountOfMoneyTextField: UITextField!
    
    enum delegateType: Int {
        case extraordinarySpending
        case extraordinaryIncome
        case fixedIncome
        case fixedSpending
        case fixedSavings
    }
    
    var delegate: CustomViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        
        detailsTextField.delegate = self
        amountOfMoneyTextField.delegate = self
        
        detailsTextField.returnKeyType = .done
        amountOfMoneyTextField.returnKeyType = .done
        amountOfMoneyTextField.keyboardType = .numberPad
    }
    
    func loadNib() {
        let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        if let details = detailsTextField.text, let amoutOfMoney = amountOfMoneyTextField.text, !details.isEmpty, !amoutOfMoney.isEmpty {
            guard let addButtonTagCount = self.delegate?.addButtonTagCount, let delegateType = delegateType(rawValue:  addButtonTagCount) else {
                return
            }
            switch delegateType {
            case .extraordinarySpending: break
//                createExtraordinarySpending(details: details, amountOfMoney: amoutOfMoney)
            case .extraordinaryIncome: break
//                createExtraordinaryIncome(details: details, amountOfMoney: amoutOfMoney)
            case .fixedIncome:
                createFixedIncome(details: details, amountOfMoney: amoutOfMoney)
            case .fixedSpending:
                createFixedSpending(details: details, amountOfMoney: amoutOfMoney)
            case .fixedSavings:
                createFixedSaving(details: details, amountOfMoney: amoutOfMoney)
            }
        }
        detailsTextField.text = .none
        amountOfMoneyTextField.text = .none
        self.endEditing(true)
        self.delegate?.closeInputView()
    }
    
//    func createExtraordinarySpending(details: String, amountOfMoney: String) {
//        var extraordinarySpending = DailyBalanceOfPayments.BalanceOfPayments()
//        extraordinarySpending.details = details
//        extraordinarySpending.amountOfMoney = amountOfMoney
//        extraordinarySpending.plusOrMinus = 0
//    }
//
//    func createExtraordinaryIncome(details: String, amountOfMoney: String) {
//        var extraordinaryIncome = DailyBalanceOfPayments.BalanceOfPayments()
//        extraordinaryIncome.details = details
//        extraordinaryIncome.amountOfMoney = amountOfMoney
//        extraordinaryIncome.plusOrMinus = 1
//    }
    
    func createFixedIncome(details: String, amountOfMoney: String) {
        let fixedIncome = FixedIncome()
        fixedIncome.details = details
        fixedIncome.amountOfMoney = amountOfMoney
        BudgetRepository.shared.addFixedIncome(fixedIncome: fixedIncome)
    }
    
    func createFixedSpending(details: String, amountOfMoney: String) {
        let fixedSpending = FixedSpending()
        fixedSpending.details = details
        fixedSpending.amountOfMoney = amountOfMoney
        BudgetRepository.shared.addFixedSpending(fixedSpeding: fixedSpending)
    }
    
    func createFixedSaving(details: String, amountOfMoney: String) {
        let fixedSaving = FixedSaving()
        fixedSaving.details = details
        fixedSaving.amountOfMoney = amountOfMoney
        BudgetRepository.shared.addFixedSaving(fixedSaving: fixedSaving)
    }
}

extension CustomView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
