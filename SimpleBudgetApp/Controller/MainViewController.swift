//
//  MainViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit
import SideMenuSwift

class MainViewController: UIViewController {

    @IBOutlet weak var monthlyBudgetLabel: CustomLabel!
    @IBOutlet weak var dailyLimitLabel: CustomLabel!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaHight: NSLayoutConstraint!
    @IBOutlet weak var selectAreaTop: NSLayoutConstraint!

    private var inputType: InputType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layerColorSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        BalanceBreakdownManagementUseCase.shared.changeDailyBudget()
        guard let navigationController = self.navigationController, (!navigationController.isNavigationBarHidden) else {
            return
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        amountSetUp()
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
}

extension MainViewController: CustomViewDelegate {
    
    func InputDidFinish(details: String, amount: String) {
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
            self.view.layoutIfNeeded()
        }
    }
}
