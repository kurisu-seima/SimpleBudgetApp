//
//  MenuViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit
import SideMenuSwift

class MenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        self.overrideUserInterfaceStyle = .light
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell") as! SideMenuCell
        cell.setupView(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sideMenuController?.hideMenu(animated: true, completion: nil)
        guard let navigationController = sideMenuController?.contentViewController as? UINavigationController else {
            return
        }
        navigationController.setNavigationBarHidden(false, animated: false)
        
        switch Menu.allCases[indexPath.row] {
        case .yourMenoy:
            sideMenuController?.hideMenu()
            navigationController.setNavigationBarHidden(true, animated: false)
        case .budgetSetting:
            let budgetVC = storyboard?.instantiateViewController(withIdentifier: "BudgetVC") as! BudgetSettingViewController
            navigationController.pushViewController(budgetVC, animated: true)
        case .balanceBreakDown:
            let balanceBreakdownVC = storyboard?.instantiateViewController(withIdentifier: "BalanceBreakdownVC") as! BalanceBreakdownViewController
            navigationController.pushViewController(balanceBreakdownVC, animated: true)
        case .monthlyRecord:
            let monthlyRecordVC = storyboard?.instantiateViewController(withIdentifier: "MonthlyRecordVC") as! MonthlyRecordViewController
            navigationController.pushViewController(monthlyRecordVC, animated: true)
        }
    }
}
