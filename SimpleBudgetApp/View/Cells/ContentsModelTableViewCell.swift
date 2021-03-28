//
//  ContentsModelTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/21.
//

import UIKit

class ContentsModelTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fixedIncomeSetUp(fixedIncome: FixedIncome) {
        detailsLabel.text = fixedIncome.details
        amountLabel.text = "¥\(Int(fixedIncome.amountOfMoney)!.numberWithComma())"
    }
    
    func fixedSpendingSetUp(fixedSpending: FixedSpending) {
        detailsLabel.text = fixedSpending.details
        amountLabel.text = "¥\(Int(fixedSpending.amountOfMoney)!.numberWithComma())"
    }
    
    func fixedSavingSetUp(fixedSaving: FixedSavings) {
        detailsLabel.text = fixedSaving.details
        amountLabel.text = "¥\(Int(fixedSaving.amountOfMoney)!.numberWithComma())"
    }
    
    func balanceBreakdownSetup(incomeAndExpenditure: IncomeAndExpenditure) {
        detailsLabel.text = incomeAndExpenditure.details
        guard let plusOrMinus = IncomeAndExpenditure.PlusOrMinus(rawValue: incomeAndExpenditure.plusOrMinus) else {
            return
        }
        switch plusOrMinus {
        case .plus:
            amountLabel.text = "¥\(Int(incomeAndExpenditure.amountOfMoney)!.numberWithComma())"
        case .minus:
            amountLabel.text = "-¥\(Int(incomeAndExpenditure.amountOfMoney)!.numberWithComma())"
        }
    }
}
