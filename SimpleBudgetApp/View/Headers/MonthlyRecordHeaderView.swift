//
//  MonthlyRecordHeaderView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/29.
//

import UIKit

class MonthlyRecordHeaderView: UITableViewHeaderFooterView {
    
    private let savePaDay = "PayDay"
    
    let payDay: Int {
       return String(UserDefaults.standard.integer(forKey: savePaDay))
    }

    @IBOutlet weak var dateLabel: UILabel!
    

    func setupMonthlyRecrdHooterView(date: Date) {
        self.tintColor = UIColor.clear
        dateLabel.text = "\(date.year)年\(date.month)月\(payDay)日〜\(date.year)年\(date.month)月\(payDay - 1)日"
    }
}
