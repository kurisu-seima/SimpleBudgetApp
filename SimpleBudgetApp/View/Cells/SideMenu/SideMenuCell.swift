//
//  SideMenuCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/20.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(index: Int) {
        menuLabel.text = Menu.allCases[index].label
        menuImage.image = UIImage(named: Menu.allCases[index].image)
    }
}
