//
//  CustomView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/20.
//

import UIKit

protocol CustomViewDelegate {
    func closeInpurView()
}

class CustomView: UIView {
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var delegate: CustomViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        
        detailsTextField.delegate = self
        amountTextField.delegate = self
        amountTextField.keyboardType = .numberPad
    }
    
    func loadNib() {
        let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @IBAction func closeInputView(_ sender: Any) {
        self.endEditing(true)
        self.delegate?.closeInpurView()
    }
}

extension CustomView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
