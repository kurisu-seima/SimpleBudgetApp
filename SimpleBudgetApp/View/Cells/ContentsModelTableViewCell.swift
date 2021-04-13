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
    @IBOutlet weak var incomeContentView: UIView!
    @IBOutlet weak var spendingContentView: UIView!
    @IBOutlet weak var savingsContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFixedIncomeVCCell(fixedIncome: FixedIncome) {
        self.backgroundColor = UIColor.clear
        detailsLabel.text = fixedIncome.details
        incomeContentView.layer.cornerRadius = 10
        amountLabel.text = "¥\(Int(fixedIncome.amountOfMoney)!.numberWithComma())"
    }
    
    func setupFixedSpendingVCCell(fixedSpending: FixedSpending) {
        self.backgroundColor = UIColor.clear
        spendingContentView.layer.cornerRadius = 10
        detailsLabel.text = fixedSpending.details
        amountLabel.text = "¥\(Int(fixedSpending.amountOfMoney)!.numberWithComma())"
    }
    
    func setupFixedSavingsVCCell(fixedSaving: FixedSavings) {
        self.backgroundColor = UIColor.clear
        savingsContentView.layer.cornerRadius = 10
        detailsLabel.text = fixedSaving.details
        amountLabel.text = "¥\(Int(fixedSaving.amountOfMoney)!.numberWithComma())"
    }
    
    func setupBalanceBreakdownVCCell(incomeAndExpenditure: IncomeAndExpenditure) {
        detailsLabel.text = incomeAndExpenditure.details
        self.backgroundColor = UIColor.clear
        guard let plusOrMinus = IncomeAndExpenditure.PlusOrMinus(rawValue: incomeAndExpenditure.plusOrMinus) else {
            return
        }
        switch plusOrMinus {
        case .plus:
            amountLabel.text = "¥\(Int(incomeAndExpenditure.amountOfMoney)!.numberWithComma())"
        case .minus:
            amountLabel.text = "¥-\(Int(incomeAndExpenditure.amountOfMoney)!.numberWithComma())"
        }
    }
}
