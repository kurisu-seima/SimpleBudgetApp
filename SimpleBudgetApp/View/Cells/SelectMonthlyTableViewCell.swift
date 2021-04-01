//
//  SelectMonthlyTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/25.
//

import UIKit

class SelectMonthlyTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupSelectMonthlyVCCell(date: Date) {
        dateLabel.text = "\(date.year)年\(date.month)月1日〜\(date.year)年\(date.month)月\(date.lastDay)日"
    }
}
