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
        
        fixedSpendingsData = MoneyManagementUseCase.shared.fixedSpendings

        amountSetUp()
        layerColorSetUp()
        spendingTableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        spendingTableView.isEditing = editing
    }
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        openInputView()
    }
    
    private func amountSetUp() {
        monthlyFixedSpendingLabel.text = "¥\(MoneyManagementUseCase.shared.getTotalAmountOfSpending().numberWithComma())"
    }
    
    private func layerColorSetUp() {
        self.navigationController?.navigationBar.barTintColor = UIColor().fixedSpendingVCNavigationColor
        self.view.layer.insertSublayer(CAGradientLayer().fixedSpendingVCLayer(frame: self.view.frame), at: 0)
    }
    
    private func openInputView() {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditingSpending") as! EditingFixedSpendingViewController
        nextVC.fixedSpending = fixedSpendingsData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        BudgetRepository.shared.delete(model: fixedSpendingsData[indexPath.row], id: fixedSpendingsData[indexPath.row].id)
        fixedSpendingsData = MoneyManagementUseCase.shared.fixedSpendings
        spendingTableView.reloadData()
        amountSetUp()
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
