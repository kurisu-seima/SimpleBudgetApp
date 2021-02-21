//
//  AddFixedSpendingViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class AddFixedSpendingViewController: UIViewController {
    
    @IBOutlet weak var spendingTableView: UITableView!
    @IBOutlet weak var spendingTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaBottomHight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openInputView(_ sender: Any) {
        selectArea.delegate = self
        selectArea.isHidden = false
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        selectAreaBottomHight.constant = 10
        spendingTableViewTopConstraint.constant = 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AddFixedSpendingViewController: CustomViewDelegate {
    func closeInpurView() {
        selectArea.isHidden = true
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = false
        selectAreaBottomHight.constant = 0
        spendingTableViewTopConstraint.constant = 80
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
