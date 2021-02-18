//BalanceBreakdownTableViewCell
//  ItemTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/18.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(item: String, amount: String) {
        itemLabel.text = item
        amountLabel.text = amount
    }
}
