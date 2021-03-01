//
//  AddFixedSavingsViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class AddFixedSavingsViewController: UIViewController {

    @IBOutlet weak var savingsTableView: UITableView!
    @IBOutlet weak var savingsTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaBottomHight: NSLayoutConstraint!
    
    var fixedSavingsData: [FixedSaving] = []
    
    var addButtonTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingsTableView.delegate = self
        savingsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fixedSavingsData = BudgetRepository.shared.fixedSavingsArray()
    }
    
    @IBAction func openInputView(_ sender: UIButton) {
        selectArea.delegate = self
        addButtonTag = sender.tag
        selectArea.isHidden = false
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        selectAreaBottomHight.constant = 10
        savingsTableViewTopConstraint.constant = 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AddFixedSavingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixedSavingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savingsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.fixedSavingSetUp(fixedSaving: fixedSavingsData[indexPath.row])
        return cell
    }
}

extension AddFixedSavingsViewController: CustomViewDelegate {
    var addButtonTagCount: Int {
        return addButtonTag
    }
    
    func closeInputView() {
        fixedSavingsData = BudgetRepository.shared.fixedSavingsArray()
        savingsTableView.reloadData()
        selectArea.isHidden = true
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = false
        selectAreaBottomHight.constant = 0
        savingsTableViewTopConstraint.constant = 80
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
