//
//  AddFixedIncomeViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class AddFixedIncomeViewController: UIViewController {
    
    @IBOutlet weak var incomeTableView: UITableView!
    @IBOutlet weak var incomeTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaBottomHight: NSLayoutConstraint!
    @IBOutlet weak var monthlyFixedIncomeLabel: UILabel!
    
    var fixedIncomesData: [FixedIncome] = []
    
    var addButtonTag: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeTableView.dataSource = self
        incomeTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fixedIncomesData = BudgetRepository.shared.fixedIncomesArray()
        labelSetUp()
        backgroundSetUp()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 170 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1)
    }
    
    @IBAction func openInputView(_ sender: UIButton) {
        selectArea.delegate = self
        addButtonTag = sender.tag
        selectArea.isHidden = false
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        selectAreaBottomHight.constant = 10
        incomeTableViewTopConstraint.constant = 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func labelSetUp() {
        monthlyFixedIncomeLabel.text = "¥\(FixedCostUseCase.shared.monthlyFixedIncome().numberWithComma())"
    }
    
    func backgroundSetUp() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        gradientLayer.colors = [UIColor(red: 74 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1).cgColor, UIColor(red: 170 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
    }
}

extension AddFixedIncomeViewController: CustomViewDelegate {
    var addButtonTagCount: Int {
        return addButtonTag
    }
    
    func closeInputView() {
        fixedIncomesData = BudgetRepository.shared.fixedIncomesArray()
        labelSetUp()
        incomeTableView.reloadData()
        selectArea.isHidden = true
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = false
        selectAreaBottomHight.constant = 0
        incomeTableViewTopConstraint.constant = 80
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
