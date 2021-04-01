//
//  MonthlyRecordHeaderView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/29.
//

import UIKit

class MonthlyRecordHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    

    func setupMonthlyRecrdHooterView(date: Date) {
        dateLabel.text = "\(date.year)年\(date.month)月1日〜\(date.year)年\(date.month)月\(date.lastDay)日"
    }
}
