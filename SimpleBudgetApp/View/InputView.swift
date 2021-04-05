//
//  InputView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/04/02.
//

import UIKit
import DSFloatingButton

protocol InputViewDelegate {
    func didFinish(details: String, amount: String)
    func closeInputView()
}

class InputView: UIView {
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var doneButton: DSFloatingButton!
    
    var delegate: InputViewDelegate? {
        didSet {
            switch delegate {
            case is AddFixedIncomeViewController:
                doneButton.gradientStartColor = UIColor().incomeStartColor
                doneButton.gradientEndColor = UIColor().incomeEndColor
                doneButton.shadowColor = UIColor().incomeEndColor
            case is AddFixedSpendingViewController:
                doneButton.gradientStartColor = UIColor().spendingStartColor
                doneButton.gradientEndColor = UIColor().spendingEndColor
                doneButton.shadowColor = UIColor().spendingStartColor
            case is AddFixedSavingsViewController:
                doneButton.gradientStartColor = UIColor().savingsStartColor
                doneButton.gradientEndColor = UIColor().savingsEndColor
                doneButton.shadowColor = UIColor().savingsStartColor
            case is EditingIncomeAndExpenditureViewController:
                //ここに色を入れる
            break
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        
        detailsTextField.delegate = self
        amountTextField.delegate = self
        
        textFieldSetUp()
    }
    
    func loadNib() {
        let view = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        if let details = detailsTextField.text, let amount = amountTextField.text,
           !details.isEmpty, !amount.isEmpty, let _ = Int(amount) {
            self.delegate?.didFinish(details: details, amount: amount)
        }
        closeInputView()
    }

    private func textFieldSetUp() {
        detailsTextField.returnKeyType = .done
        amountTextField.returnKeyType = .done
        amountTextField.keyboardType = .numberPad
    }
    
    private func closeInputView() {
        detailsTextField.text = .none
        amountTextField.text = .none
        self.endEditing(true)
        self.delegate?.closeInputView()
    }
}

extension InputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
