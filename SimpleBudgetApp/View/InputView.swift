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
    @IBOutlet weak var closeButton: DSFloatingButton!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var delegate: InputViewDelegate? {
        didSet {
            setupDoneButton(delegate: delegate)
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
            closeInputView()
        }
    }

    @IBAction func closeButtonDidTapped(_ sender: Any) {
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
    
    private func setupDoneButton(delegate: InputViewDelegate?) {
        switch delegate {
        case is MainViewController:
            doneButton.gradientStartColor = UIColor().mainStartColor
            doneButton.gradientEndColor = UIColor().mainEndColor
            doneButton.gradientStartPoint = CGPoint(x: 1, y: 0.5)
            doneButton.gradientEndPoint = CGPoint(x: 1, y: 0)
            closeButton.gradientStartColor = UIColor().mainStartColor
            closeButton.gradientEndColor = UIColor().mainEndColor
            closeButton.gradientStartPoint = CGPoint(x: 1, y: 0.5)
            closeButton.gradientEndPoint = CGPoint(x: 1, y: 0)
            
        case is AddFixedIncomeViewController:
            doneButton.gradientStartColor = UIColor().incomeStartColor
            doneButton.gradientEndColor = UIColor().incomeEndColor
            closeButton.gradientStartColor = UIColor().incomeStartColor
            closeButton.gradientEndColor = UIColor().incomeEndColor
            
        case is AddFixedSpendingViewController:
            doneButton.gradientStartColor = UIColor().spendingStartColor
            doneButton.gradientEndColor = UIColor().spendingEndColor
            closeButton.gradientStartColor = UIColor().spendingStartColor
            closeButton.gradientEndColor = UIColor().spendingEndColor
            
        case is AddFixedSavingsViewController:
            doneButton.gradientStartColor = UIColor().savingsStartColor
            doneButton.gradientEndColor = UIColor().savingsEndColor
            closeButton.gradientStartColor = UIColor().savingsStartColor
            closeButton.gradientEndColor = UIColor().savingsEndColor
            
        case is AddIncomeAndExpenditureViewController:
            doneButton.gradientStartColor = UIColor().orangeStartColor
            doneButton.gradientEndColor = UIColor().orangeEndColor
            closeButton.gradientStartColor = UIColor().orangeStartColor
            closeButton.gradientEndColor = UIColor().orangeEndColor
        case is PayDaySettingViewController:
            setupPayDayInputView()
            doneButton.gradientStartColor = UIColor().payDayStartColor
            doneButton.gradientEndColor = UIColor().payDayEndColor
            closeButton.gradientStartColor = UIColor().payDayStartColor
            closeButton.gradientEndColor = UIColor().payDayEndColor
        default:
            break
        }
    }
    
    private func setupPayDayInputView() {
        detailsLabel.text = "メモ"
        detailsTextField.placeholder = "メモを入力することができます"
        amountLabel.text = "日付"
        amountTextField.placeholder = "日付を入力してください"
    }
}

extension InputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
