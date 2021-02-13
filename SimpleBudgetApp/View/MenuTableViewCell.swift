//
//  MenuTableViewCell.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/08.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuListTitle: UILabel!
    
    @IBOutlet weak var menuListImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(index: Int) {
        menuListTitle.text = Menu.allCases[index].label
        menuListImage.image = UIImage(named: Menu.allCases[index].image)
    }
}
