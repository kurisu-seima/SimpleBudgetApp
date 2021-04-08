//
//  AddIncomeAndExpenditureViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/27.
//

import UIKit

class AddIncomeAndExpenditureViewController: UIViewController {
    
    @IBOutlet weak var customView: InputView!
    @IBOutlet weak var topLabel: UILabel!
    
    var inputType: InputType?
    
    var date: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupView()
    }
    
    private func setupView() {
        self.view.layer.insertSublayer(CAGradientLayer().balanceBreakdoenLayer(frame: self.view.frame), at: 0)
        switch inputType {
        case .income:
            topLabel.text = "臨時収入を追加できます"
        case .spending:
            topLabel.text = "臨時支出を追加できます"
        default:
            break
        }
    }
}

extension AddIncomeAndExpenditureViewController: InputViewDelegate {
    func didFinish(details: String, amount: String) {
        switch inputType {
        case .spending:
            guard let date = date else {
                return
            }
            IncomeAndExpenditureUseCase.shared.addSelected(IncomeAndExpenditure(details: details, amount: amount, plusOrMinus: .minus), date: date)
        case .income:
            guard let date = date else {
                return
            }
            IncomeAndExpenditureUseCase.shared.addSelected(IncomeAndExpenditure(details: details, amount: amount, plusOrMinus: .plus), date: date)
        case .none: break
        case .some(_): break
        }
        inputType = nil
    }
    
    func closeInputView() {
        self.navigationController?.popViewController(animated: true)
    }  
}
