//
//  SelectMonthlyTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/25.
//

import UIKit

class SelectMonthlyTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    private let savePaDay = "PayDay"
    
    let payDay: Int {
       return String(UserDefaults.standard.integer(forKey: savePaDay))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupSelectMonthlyVCCell(date: Date) {
        dateLabel.text = "\(date.year)年\(date.month)月\(payDay)日〜\(date.year)年\(date.month)月\(payDay - 1)日"
        self.backgroundColor = UIColor.clear
    }
}
