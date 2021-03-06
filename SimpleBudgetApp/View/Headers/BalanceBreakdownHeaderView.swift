//
//  BalanceBreakdownHeaderView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/04/01.
//

import UIKit

class BalanceBreakdownHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    
    var date: Date?
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            guard let viewController = self.parentViewController else {
                return
            }
            let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "IncomeAndExpenditure") as! AddIncomeAndExpenditureViewController
            nextVC.inputType = .spending
            nextVC.date = date
            viewController.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            guard let viewController = self.parentViewController else {
                return
            }
            let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "IncomeAndExpenditure") as! AddIncomeAndExpenditureViewController
            nextVC.inputType = .income
            nextVC.date = date
            viewController.navigationController?.pushViewController(nextVC, animated: true)
        default: break
        }
    }
    
    func setupHeaderView(dailyIncomeAndExpenditure: DailyIncomeAndExpenditure) {
        dateLabel.text = dailyIncomeAndExpenditure.primaryDate
        self.tintColor = UIColor.clear
        self.date = dailyIncomeAndExpenditure.date
    }
}
