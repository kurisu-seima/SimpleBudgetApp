//
//  MonthlyRecordTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/30.
//

import UIKit

class MonthlyRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var fixedIncomeAmountLabel: UILabel!
    @IBOutlet weak var fixedSpendingAmountLabel: UILabel!
    @IBOutlet weak var fixedSavingsAmountLabel: UILabel!
    @IBOutlet weak var extraordinaryIncomeAmountLabel: UILabel!
    @IBOutlet weak var extraordinarySpendingAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupMonthlyRecordView(fixedIncome: Int, fixedSpending: Int, fixedSavings: Int, extraordinaryIncome: Int, extraordinarySpending: Int) {
        fixedIncomeAmountLabel.text = "¥\(fixedIncome.numberWithComma())"
        extraordinaryIncomeAmountLabel.text = "¥\(extraordinaryIncome.numberWithComma())"
        fixedSpendingAmountLabel.text = "¥\(fixedSpending.numberWithComma())"
        extraordinarySpendingAmountLabel.text = "¥\(extraordinarySpending.numberWithComma())"
        fixedSavingsAmountLabel.text = "¥\(fixedSavings.numberWithComma())"
    }
}
