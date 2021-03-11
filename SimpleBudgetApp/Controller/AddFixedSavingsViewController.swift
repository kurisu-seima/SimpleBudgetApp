//
//  AddFixedSavingsViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class AddFixedSavingsViewController: UIViewController {

    @IBOutlet weak var savingsTableView: UITableView!
    @IBOutlet weak var savingsTableViewTop: NSLayoutConstraint!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaHight: NSLayoutConstraint!
    @IBOutlet weak var selectAreaBottom: NSLayoutConstraint!
    @IBOutlet weak var monthlyFixedSavingsLabel: UILabel!
    var fixedSavingsData: [FixedSavings] = []
    
    private var inputType: InputType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingsTableView.delegate = self
        savingsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fixedSavingsData = BudgetRepository.shared.fixedSavingsArray()
        labelSetUp()
        layerColorSetUp()
    }
    
    @IBAction func openInputView(_ sender: UIButton) {
        inputType = .fixedSavings
        selectArea.delegate = self
        selectArea.isHidden = false
        savingsTableViewTop.constant = 130
        selectAreaBottom.constant = 0
        selectAreaHight.constant = 400
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func labelSetUp() {
        monthlyFixedSavingsLabel.text = "¥\(FixedCostUseCase.shared.monthlyFixedSaving().numberWithComma())"
    }
    
    private func layerColorSetUp() {
        self.navigationController?.navigationBar.barTintColor = UIColor().fixedSavingsVCNavigationColor
        self.view.layer.insertSublayer(CAGradientLayer().fixedSavingsVCLayer(frame: self.view.frame), at: 0)
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
    func InputDidFinish(details: String, amount: String) {
        switch inputType {
        case .fixedSavings:
            let fixedSavings = FixedSavings()
            fixedSavings.details = details
            fixedSavings.amountOfMoney = amount
            BudgetRepository.shared.add(fixedSavings)
        case .none: break
        case .some(_): break
        }
        inputType = nil
        
        fixedSavingsData = BudgetRepository.shared.fixedSavingsArray()
        savingsTableView.reloadData()
        labelSetUp()
    }
    
    func closeInputView() {
        selectArea.isHidden = false
        selectAreaHight.constant = 0
        selectAreaBottom.constant = -550
        savingsTableViewTop.constant = 80
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}
