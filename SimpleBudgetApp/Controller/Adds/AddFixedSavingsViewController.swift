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
    @IBOutlet weak var selectArea: InputView!
    @IBOutlet weak var selectAreaHight: NSLayoutConstraint!
    @IBOutlet weak var selectAreaBottom: NSLayoutConstraint!
    @IBOutlet weak var monthlyFixedSavingsLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    
    var fixedSavingsData: [FixedSavings] = []
    
    private var inputType: InputType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingsTableView.delegate = self
        savingsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fixedSavingsData = MoneyManagementUseCase.shared.fixedSavings
        amountSetUp()
        layerColorSetUp()
        savingsTableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        savingsTableView.isEditing = editing
    }
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        openInputView()
    }
    
    private func amountSetUp() {
        monthlyFixedSavingsLabel.text = "¥\(MoneyManagementUseCase.shared.getTotalAmountOfFixedSavings().numberWithComma())"
    }
    
    private func layerColorSetUp() {
        self.view.layer.insertSublayer(CAGradientLayer().fixedSavingsVCLayer(frame: self.view.frame), at: 0)
        savingsTableView.backgroundColor = UIColor.clear
    }
    
    private func openInputView() {
        selectArea.delegate = self
        inputType = .fixedSavings
        selectArea.isHidden = false
        savingsTableViewTop.constant = 130
        selectAreaBottom.constant = 0
        selectAreaHight.constant = 400
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            topLabel.alpha = 0
            monthlyFixedSavingsLabel.alpha = 0
            addButton.alpha = 0
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}

extension AddFixedSavingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixedSavingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savingsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContentsModelTableViewCell
        cell.setupFixedSavingsVCCell(fixedSaving: fixedSavingsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditingSavings") as! EditingFixedSavingsViewController
        nextVC.fixedSavings = fixedSavingsData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        BudgetRepository.shared.delete(model: fixedSavingsData[indexPath.row], id: fixedSavingsData[indexPath.row].id)
        fixedSavingsData = MoneyManagementUseCase.shared.fixedSavings
        savingsTableView.reloadData()
        amountSetUp()
    }
}

extension AddFixedSavingsViewController: InputViewDelegate {
    func didFinish(details: String, amount: String) {
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
        
        fixedSavingsData = MoneyManagementUseCase.shared.fixedSavings
        savingsTableView.reloadData()
        amountSetUp()
    }
    
    func closeInputView() {
        selectArea.isHidden = false
        selectAreaHight.constant = 0
        selectAreaBottom.constant = -550
        savingsTableViewTop.constant = 80
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            topLabel.alpha = 1
            monthlyFixedSavingsLabel.alpha = 1
            addButton.alpha = 1
            view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}
