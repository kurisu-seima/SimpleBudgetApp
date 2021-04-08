//
//  BudgetSettingViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class BudgetSettingViewController: UIViewController {

    @IBOutlet weak var dailyBudgetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupView()
    }
    
    @IBAction func fixedButtonDidTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let fixedIncomeVC = storyboard?.instantiateViewController(withIdentifier: "FixedIncome") as! AddFixedIncomeViewController
            self.navigationController?.pushViewController(fixedIncomeVC, animated: true)
        case 1:
            let fixedSpendingVC = storyboard?.instantiateViewController(withIdentifier: "FixedSpending") as! AddFixedSpendingViewController
            self.navigationController?.pushViewController(fixedSpendingVC, animated: true)
        case 2:
            let fixedSavingsVC = storyboard?.instantiateViewController(withIdentifier: "FixedSavings") as! AddFixedSavingsViewController
            self.navigationController?.pushViewController(fixedSavingsVC, animated: true)
        default:
            break
        }
    }
    
    private func setupView() {
        dailyBudgetLabel.text = "¥\(MoneyManagementUseCase.shared.getDailyBudget().numberWithComma())"
        self.view.layer.insertSublayer(CAGradientLayer().budgetVCLayer(frame: self.view.frame), at: 0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
