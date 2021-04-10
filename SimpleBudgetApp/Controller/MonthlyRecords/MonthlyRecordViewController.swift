//
//  MonthlyRecordViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class MonthlyRecordViewController: UIViewController {

    @IBOutlet weak var monthlyRecordTableView: UITableView!
    
    var savedDates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        monthlyRecordTableView.dataSource = self
        monthlyRecordTableView.delegate = self
        
        let headerXib = UINib(nibName: "MonthlyRecordHeaderView", bundle: nil)
        monthlyRecordTableView.register(headerXib, forHeaderFooterViewReuseIdentifier: "MonthlyRecordHeaderView")
        
        let footerXib = UINib(nibName: "TotalAmountFooterView", bundle: nil)
        monthlyRecordTableView.register(footerXib, forHeaderFooterViewReuseIdentifier: "TotalAmountFooterView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        savedDates = AppSettingUseCase.shared.savedDates.sorted(by: >)
        setupView()
    }
    
    private func setupView() {
        self.view.layer.insertSublayer(CAGradientLayer().monthlyRecordVCLayer(frame: self.view.frame), at: 0)
        monthlyRecordTableView.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 240 / 255, green: 222 / 255, blue: 220 / 255, alpha: 1)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension MonthlyRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return savedDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = monthlyRecordTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MonthlyRecordTableViewCell
        cell.setupMonthlyRecordView(fixedIncome: MoneyManagementUseCase.shared.getMonthlyFixedIncomesAmounts[indexPath.row],
                                    fixedSpending: MoneyManagementUseCase.shared.getMonthlyFixedSpendingsAmounts[indexPath.row],
                                    fixedSavings: MoneyManagementUseCase.shared.getMonthlyFixedSavingsAmounts[indexPath.row],
                                    extraordinaryIncome: MoneyManagementUseCase.shared.getMonthlyExtraordinaryIncomeAmounts[indexPath.row],
                                    extraordinarySpending: MoneyManagementUseCase.shared.getMonthlyExtraordinarySpendingAmounts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = monthlyRecordTableView.dequeueReusableHeaderFooterView(withIdentifier: "MonthlyRecordHeaderView") as! MonthlyRecordHeaderView
        headerView.setupMonthlyRecrdHooterView(date: savedDates[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hooterView = monthlyRecordTableView.dequeueReusableHeaderFooterView(withIdentifier: "TotalAmountFooterView") as! TotalAmountFooterView
        hooterView.setupMonthlyRecordFooterView(fixedIncome: MoneyManagementUseCase.shared.getMonthlyFixedIncomesAmounts[section],
                                                fixedSpending: MoneyManagementUseCase.shared.getMonthlyFixedSpendingsAmounts[section],
                                                fixedSavings: MoneyManagementUseCase.shared.getMonthlyFixedSavingsAmounts[section],
                                                extraordinaryIncome: MoneyManagementUseCase.shared.getMonthlyExtraordinaryIncomeAmounts[section],
                                                extraordinarySpending: MoneyManagementUseCase.shared.getMonthlyExtraordinarySpendingAmounts[section])
        return hooterView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
