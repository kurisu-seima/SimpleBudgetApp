//
//  CustomView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/20.
//

import UIKit
import RealmSwift

protocol CustomViewDelegate {
    func InputDidFinish(details: String, amount: String)
    func closeInputView()
}

class CustomView: UIView {
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var amountOfMoneyTextField: UITextField!
    @IBOutlet weak var detalsContentView: UIView!
    @IBOutlet weak var amountContentView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
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
        
        textFieldSetUp()
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
        if let details = detailsTextField.text, let amount = amountOfMoneyTextField.text,
           !details.isEmpty, !amount.isEmpty {
            //ここに数字であれば進む処理
            self.delegate?.InputDidFinish(details: details, amount: amount)
        }
        closeInputView()
    }
    
    private func textFieldSetUp() {
        detailsTextField.returnKeyType = .done
        amountOfMoneyTextField.returnKeyType = .done
        amountOfMoneyTextField.keyboardType = .numberPad
    }
    
    private func closeInputView() {
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
