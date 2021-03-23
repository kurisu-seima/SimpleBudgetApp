//
//  FooterView.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/21.
//

import UIKit

class FooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var totalAmountLabel: UILabel!
    
    func setupFooterView(total: Int) {
        self.tintColor = .white
        
        switch total {
        case let total where total == 0:
            totalAmountLabel.textColor = .black
            totalAmountLabel.text = "¥\(total.numberWithComma())"
        case let total where total > 0:
            totalAmountLabel.textColor = .blue
            totalAmountLabel.text = "¥\(total.numberWithComma())"
        case let total where total < 0:
            totalAmountLabel.textColor = .red
            totalAmountLabel.text = "-¥\((total * -1).numberWithComma())"
        default: break
        }
    }
}
