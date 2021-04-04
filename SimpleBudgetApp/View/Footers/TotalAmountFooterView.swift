//
//  TotalAmountFooterView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/04/01.
//

import UIKit

class TotalAmountFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var totalAmountLabel: UILabel!
    
    func setupBalanceBreakdownFooterView(total: Int) {
        self.tintColor = .white
        setupTextColor(total: total)
    }
    
    func setupMonthlyRecordFooterView(fixedIncome: Int, fixedSpending: Int, fixedSavings: Int, extraordinaryIncome: Int, extraordinarySpending: Int) {
        self.tintColor = .white
        let total = fixedIncome - fixedSpending - fixedSavings + extraordinaryIncome - extraordinarySpending
        setupTextColor(total: total)
    }
    
    private func setupTextColor(total: Int) {
        switch total {
        case let total where total == 0:
            totalAmountLabel.textColor = .black
            totalAmountLabel.text = "¥\(total.numberWithComma())"
        case let total where total > 0:
            totalAmountLabel.textColor = .blue
            totalAmountLabel.text = "¥\(total.numberWithComma())"
        case let total where total < 0:
            totalAmountLabel.textColor = .red
            totalAmountLabel.text = "¥-\((total * -1).numberWithComma())"
        default: break
        }
    }
}
