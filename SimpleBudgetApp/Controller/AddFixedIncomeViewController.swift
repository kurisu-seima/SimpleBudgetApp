//
//  AddFixedIncomeViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class AddFixedIncomeViewController: UIViewController {
    
    @IBOutlet weak var incomeTableView: UITableView!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaHight: NSLayoutConstraint!
    @IBOutlet weak var monthlyFixedIncomeLabel: UILabel!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var selectAreabottom: NSLayoutConstraint!
    
    var fixedIncomesData: [FixedIncome] = []
    
    private var inputType: InputType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeTableView.dataSource = self
        incomeTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fixedIncomesData = MoneyManagementUseCase.shared.fixedIncomes
        amountSetUp()
        layerColorSetUp()
        incomeTableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        incomeTableView.isEditing = editing
    }
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        openInputView()
        inputType = .fixedIncome
    }
    
    
    private func amountSetUp() {
        monthlyFixedIncomeLabel.text = "¥\(MoneyManagementUseCase.shared.getTotalAmountOfIncome().numberWithComma())"
    }
    
    private func layerColorSetUp() {
        self.navigationController?.navigationBar.barTintColor = UIColor().fixedIncomeVCNavigationColor
        self.view.layer.insertSublayer(CAGradientLayer().fixedIncomeVCLayer(frame: self.view.frame), at: 0)
    }
    
    private func openInputView() {
        selectArea.delegate = self
        selectArea.isHidden = false
        tableViewTop.constant = 130
        selectAreabottom.constant = 0
        selectAreaHight.constant = 400
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}

extension AddFixedIncomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixedIncomesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = incomeTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.fixedIncomeSetUp(fixedIncome: fixedIncomesData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditingIncome") as! EditingFixedIncomeViewController
        nextVC.fixedIncome = fixedIncomesData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        BudgetRepository.shared.delete(model: fixedIncomesData[indexPath.row], id: fixedIncomesData[indexPath.row].id)
        fixedIncomesData = MoneyManagementUseCase.shared.fixedIncomes
        incomeTableView.reloadData()
        amountSetUp()
    }
}

extension AddFixedIncomeViewController: CustomViewDelegate {
    func InputDidFinish(details: String, amount: String) {
        switch inputType {
        case .fixedIncome:
            let fixedIncome = FixedIncome()
            fixedIncome.details = details
            fixedIncome.amountOfMoney = amount
            BudgetRepository.shared.add(fixedIncome)
        case .none: break
        case .some(_): break
        }
        
        inputType = nil
        fixedIncomesData = MoneyManagementUseCase.shared.fixedIncomes
        incomeTableView.reloadData()
        amountSetUp()
    }
    
    func closeInputView() {
        selectArea.isHidden = false
        selectAreaHight.constant = 0
        selectAreabottom.constant = -550
        tableViewTop.constant = 80
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}
