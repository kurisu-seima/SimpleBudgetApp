//
//  SelectDailyIncomeAndExpendituresViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/23.
//

import UIKit

class SelectDailyIncomeAndExpendituresViewController: UIViewController {

    @IBOutlet weak var selectTableView: UITableView!
    
    var saveDates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectTableView.delegate = self
        selectTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        saveDates = AppSettingUseCase.shared.saveDates
    }
}

extension SelectDailyIncomeAndExpendituresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        saveDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectMonthlyTableViewCell
        cell.setupDateLabel(date: saveDates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectTableView.deselectRow(at: indexPath, animated: true)
        guard let navigationController = self.navigationController else {
            return
        }
        let balanceBreakdownVC = navigationController.viewControllers[navigationController.viewControllers.count - 2] as! BalanceBreakdownViewController
        balanceBreakdownVC.selectedYear = saveDates[indexPath.row].year
        balanceBreakdownVC.selectedMonth = saveDates[indexPath.row].month
        balanceBreakdownVC.dateType = .selected
        self.navigationController?.popViewController(animated: true)
    }
}
