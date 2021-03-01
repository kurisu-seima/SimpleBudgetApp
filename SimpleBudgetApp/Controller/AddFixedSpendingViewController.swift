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
    @IBOutlet weak var addButton: UIButton!
    
    var fixedSpendingsData: [FixedSpending] = []
    
    var addButtonTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spendingTableView.delegate = self
        spendingTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fixedSpendingsData = BudgetRepository.shared.fixedSpendingsArray()
    }
    
    @IBAction func openInputView(_ sender: UIButton) {
        selectArea.delegate = self
        addButtonTag = sender.tag
        selectArea.isHidden = false
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        selectAreaBottomHight.constant = 10
        spendingTableViewTopConstraint.constant = 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AddFixedSpendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixedSpendingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = spendingTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.fixedSpendingSetUp(fixedSpending: fixedSpendingsData[indexPath.row])
        return cell
    }
}

extension AddFixedSpendingViewController: CustomViewDelegate {
    var addButtonTagCount: Int {
        return addButtonTag
    }
    
    func closeInputView() {
        fixedSpendingsData = BudgetRepository.shared.fixedSpendingsArray()
        spendingTableView.reloadData()
        selectArea.isHidden = true
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = false
        selectAreaBottomHight.constant = 0
        spendingTableViewTopConstraint.constant = 80
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
