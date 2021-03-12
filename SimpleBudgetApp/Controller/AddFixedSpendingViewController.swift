//
//  AddFixedSpendingViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class AddFixedSpendingViewController: UIViewController {
    
    @IBOutlet weak var spendingTableView: UITableView!
    @IBOutlet weak var spendingTableViewTop: NSLayoutConstraint!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaHight: NSLayoutConstraint!
    @IBOutlet weak var selectAreaBottom: NSLayoutConstraint!
    @IBOutlet weak var monthlyFixedSpendingLabel: UILabel!
    
    var fixedSpendingsData: [FixedSpending] = []
    
    private var inputType: InputType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spendingTableView.delegate = self
        spendingTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        fixedSpendingsData = MoneyManagementUseCase.shared.fixedSpendings

        amountSetUp()
        layerColorSetUp()
    }
    
    @IBAction func openInputView(_ sender: UIButton) {
        inputType = .fixedSpending
        selectArea.delegate = self
        selectArea.isHidden = false
        spendingTableViewTop.constant = 130
        selectAreaBottom.constant = 0
        selectAreaHight.constant = 400
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func amountSetUp() {
        monthlyFixedSpendingLabel.text = "¥\(MoneyManagementUseCase.shared.getTotalAmountOfSpending().numberWithComma())"
    }
    
    private func layerColorSetUp() {
        self.navigationController?.navigationBar.barTintColor = UIColor().fixedSpendingVCNavigationColor
        self.view.layer.insertSublayer(CAGradientLayer().fixedSpendingVCLayer(frame: self.view.frame), at: 0)
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
    func InputDidFinish(details: String, amount: String) {
        switch inputType {
        case .fixedSpending:
            let fixedSpending = FixedSpending()
            fixedSpending.details = details
            fixedSpending.amountOfMoney = amount
            BudgetRepository.shared.add(fixedSpending)
        case .none: break
        case .some: break
        }
        
        inputType = nil
        fixedSpendingsData = MoneyManagementUseCase.shared.fixedSpendings
        spendingTableView.reloadData()
        amountSetUp()
        
    }
    
    func closeInputView() {
        selectArea.isHidden = false
        selectAreaHight.constant = 0
        selectAreaBottom.constant = -550
        spendingTableViewTop.constant = 80
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}
