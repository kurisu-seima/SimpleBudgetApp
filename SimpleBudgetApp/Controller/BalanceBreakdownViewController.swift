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
    
    enum MonthlyType {
        case now
        case selected
    }
    
    var monthlyType: MonthlyType = .now
    
    var selectYear: Int = 0
    var selectMonth: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceBreakdownTableView.dataSource = self
        balanceBreakdownTableView.delegate = self
        
        let headerXib = UINib(nibName: "HeaderView", bundle: nil)
        balanceBreakdownTableView.register(headerXib, forHeaderFooterViewReuseIdentifier: "HeaderView")
        
        let footerXib = UINib(nibName: "FooterView", bundle: nil)
        balanceBreakdownTableView.register(footerXib, forHeaderFooterViewReuseIdentifier: "FooterView")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        switch monthlyType {
        case .now:
            dailyIncomeAndExpenditures = BalanceBreakdownUseCase.shared.thisMonthDailyIncomeAndExpenditures
        case .selected:
            dailyIncomeAndExpenditures = BalanceBreakdownUseCase.shared.getSelectedMonthDailyIncomeAndExpenditures(year: selectYear, month: selectMonth)
        }
        setupView()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGray5
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(goSelectVC))
    }
    
    @objc func goSelectVC() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "SelectVC") as! SelectDailyIncomeAndExpendituresViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
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
        cell.balanceBreakdownSetup(incomeAndExpenditure: dailyIncomeAndExpenditures[indexPath.section].incomeAndExpenditures[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = balanceBreakdownTableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.setupHeaderView(dailyIncomeAndExpenditure: dailyIncomeAndExpenditures[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = balanceBreakdownTableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterView") as! FooterView
        footerView.setupFooterView(total: MoneyManagementUseCase.shared.getDailyTotalAmounts(dailyIncomeAndExpenditures: dailyIncomeAndExpenditures)[section])
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
    }
}
