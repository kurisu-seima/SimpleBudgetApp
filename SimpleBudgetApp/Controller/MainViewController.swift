//
//  MainViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit
import SideMenuSwift

class MainViewController: UIViewController {

    @IBOutlet weak var monthlyBudgetLabel: CountupLabel!
    @IBOutlet weak var monthlyTextLabel: UILabel!
    @IBOutlet weak var dailyLimitLabel: CountupLabel!
    @IBOutlet weak var dailyTextLabel: UILabel!
    @IBOutlet weak var selectArea: InputView!
    @IBOutlet weak var selectAreaHight: NSLayoutConstraint!
    @IBOutlet weak var selectAreaTop: NSLayoutConstraint!

    private var inputType: InputType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layerColorSetUp()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        self.navigationController?.isNavigationBarHidden = true
        BalanceBreakdownManagementUseCase.shared.saveDailyBudget()
        amountSetUp()
        setupView()
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    @IBAction func openInputView(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            inputType = .spending
        case 1:
            inputType = .income
        default: break
        }
        selectArea.delegate = self
        selectArea.isHidden = false
        selectAreaHight.constant = 900
        selectAreaTop.constant = 10
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            monthlyBudgetLabel.alpha = 0
            dailyLimitLabel.alpha = 0
            monthlyTextLabel.alpha = 0
            dailyTextLabel.alpha = 0
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func amountSetUp() {
        monthlyBudgetLabel.animate(from: 0, to: MoneyManagementUseCase.shared.getMonthlyBudget(), duration: 0.9)
        dailyLimitLabel.animate(from: 0, to: MoneyManagementUseCase.shared.getTodayBudget(), duration: 0.9)
    }
    
    private func layerColorSetUp() {
        self.view.layer.insertSublayer(CAGradientLayer().mainLayer(frame: self.view.frame), at: 0)
        selectArea.layer.insertSublayer(CAGradientLayer().mainLayer(frame: self.view.frame), at: 0)
    }
    
    private func setupView() {
        monthlyTextLabel.adjustsFontSizeToFitWidth = true
        monthlyBudgetLabel.adjustsFontSizeToFitWidth = true
        dailyTextLabel.adjustsFontSizeToFitWidth = true
        dailyLimitLabel.adjustsFontSizeToFitWidth = true
    }
}

extension MainViewController: InputViewDelegate {
    
    func didFinish(details: String, amount: String) {
        switch inputType {
        case .spending:
            IncomeAndExpenditureUseCase.shared.addToday(IncomeAndExpenditure(details: details, amount: amount, plusOrMinus: .minus))
        case .income:
            IncomeAndExpenditureUseCase.shared.addToday(IncomeAndExpenditure(details: details, amount: amount, plusOrMinus: .plus)) 
        case .none: break
        case .some(_): break
        }
        inputType = nil
        amountSetUp()
    }
    
    func closeInputView() {
        selectArea.isHidden = false
        selectAreaHight.constant = 0
        selectAreaTop.constant = 900
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 0
            monthlyBudgetLabel.alpha = 1
            dailyLimitLabel.alpha = 1
            monthlyTextLabel.alpha = 1
            dailyTextLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}
