//
//  BalanceBreakdownViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class BalanceBreakdownViewController: UIViewController {
    
    @IBOutlet weak var balanceBreakdownTableView: UITableView!
    
    var dailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] = []
    
    enum DateType {
        case now
        case selected
    }
    
    var dateType: DateType = .now
    var selectedYear: Int = 0
    var selectedMonth: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceBreakdownTableView.dataSource = self
        balanceBreakdownTableView.delegate = self
        
        let headerXib = UINib(nibName: "BalanceBreakdownHeaderView", bundle: nil)
        balanceBreakdownTableView.register(headerXib, forHeaderFooterViewReuseIdentifier: "BalanceBreakdownHeaderView")
        
        let footerXib = UINib(nibName: "TotalAmountFooterView", bundle: nil)
        balanceBreakdownTableView.register(footerXib, forHeaderFooterViewReuseIdentifier: "TotalAmountFooterView")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupData()
        balanceBreakdownTableView.reloadData()
        setupView()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        balanceBreakdownTableView.isEditing = editing
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGray5
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(goSelectVC))
    }
    
    @objc func goSelectVC() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "SelectVC") as! SelectMonthlyViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func setupData() {
        switch dateType {
        case .now:
            dailyIncomeAndExpenditures = BalanceBreakdownManagementUseCase.shared.thisMonthDailyIncomeAndExpenditures
        case .selected:
            dailyIncomeAndExpenditures = BalanceBreakdownManagementUseCase.shared.getSelectedDailyIncomeAndExpenditures(year: selectedYear, month: selectedMonth)
        }
    }
}

extension BalanceBreakdownViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyIncomeAndExpenditures.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyIncomeAndExpenditures[section].incomeAndExpenditures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = balanceBreakdownTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContentsModelTableViewCell
        cell.setupBalanceBreakdownVCCell(incomeAndExpenditure: dailyIncomeAndExpenditures[indexPath.section].incomeAndExpenditures[indexPath.row])
        if indexPath.row == 0 {
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = balanceBreakdownTableView.dequeueReusableHeaderFooterView(withIdentifier: "BalanceBreakdownHeaderView") as! BalanceBreakdownHeaderView
        headerView.setupHeaderView(dailyIncomeAndExpenditure: dailyIncomeAndExpenditures[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = balanceBreakdownTableView.dequeueReusableHeaderFooterView(withIdentifier: "TotalAmountFooterView") as! TotalAmountFooterView
        footerView.setupBalanceBreakdownFooterView(total: MoneyManagementUseCase.shared.getDailyTotalAmounts(dailyIncomeAndExpenditures: dailyIncomeAndExpenditures)[section])
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditingIncomeAndExpenditure") as! EditingIncomeAndExpenditureViewController
        nextVC.incomeAndExpenditure = dailyIncomeAndExpenditures[indexPath.section].incomeAndExpenditures[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        BudgetRepository.shared.delete(model: dailyIncomeAndExpenditures[indexPath.section].incomeAndExpenditures[indexPath.row], id: dailyIncomeAndExpenditures[indexPath.section].incomeAndExpenditures[indexPath.row].id)
        setupData()
        balanceBreakdownTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        indexPath.row == 0 ? .none : .delete
    }
}
