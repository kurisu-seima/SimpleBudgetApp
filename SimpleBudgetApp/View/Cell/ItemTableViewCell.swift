//BalanceBreakdownTableViewCell
//  ItemTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/18.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var amountOfMonsyLabel: UILabel!
    
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
        amountOfMonsyLabel.text = "¥\(Int(fixedIncome.amountOfMoney)!.numberWithComma())"
    }
    
    func fixedSpendingSetUp(fixedSpending: FixedSpending) {
        detailsLabel.text = fixedSpending.details
        amountOfMonsyLabel.text = "¥\(Int(fixedSpending.amountOfMoney)!.numberWithComma())"
    }
    
    func fixedSavingSetUp(fixedSaving: FixedSaving) {
        detailsLabel.text = fixedSaving.details
        amountOfMonsyLabel.text = "¥\(Int(fixedSaving.amountOfMoney)!.numberWithComma())"
    }
}
