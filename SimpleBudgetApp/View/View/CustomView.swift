//
//  CustomView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/20.
//

import UIKit

protocol CustomViewDelegate {
    func closeInputView()
}

class CustomView: UIView {
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var amountOfMoneyTextField: UITextField!
    
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
    
    @IBAction func doneButtonDidTapped(_ sender: Any) {
        if let details = detailsTextField.text, let amoutOfMoney = amountOfMoneyTextField.text, !details.isEmpty, !amoutOfMoney.isEmpty {
            let fixedIncome = FixedIncome()
            fixedIncome.details = details
            fixedIncome.amountOfMoney = amoutOfMoney
            BudgetRepository.shared.addFixedIncome(fixedIncome: fixedIncome)
        }
        detailsTextField.text = .none
        amountOfMoneyTextField.text = .none
        self.endEditing(true)
        self.delegate?.closeInputView()
    }
}

extension CustomView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
