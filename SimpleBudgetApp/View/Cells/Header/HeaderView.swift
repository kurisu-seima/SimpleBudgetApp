//
//  HeaderView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/21.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func setupHeaderView(dailyIncomeAndExpenditure: DailyIncomeAndExpenditure) {
        dateLabel.text = dailyIncomeAndExpenditure.primaryDate
        self.backgroundColor = UIColor.systemGray5
    }
}
