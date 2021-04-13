//
//  SelectMonthlyViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/04/01.
//

import UIKit

class SelectMonthlyViewController: UIViewController {

    @IBOutlet weak var selectMonthlyTableView: UITableView!
    
    private var savedDates: [Date] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        selectMonthlyTableView.delegate = self
        selectMonthlyTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        savedDates = AppSettingUseCase.shared.savedDates.sorted(by: >)
        setupView()
    }
    
    private func setupView() {
        self.view.layer.insertSublayer(CAGradientLayer().mainLayer(frame: self.view.frame), at: 0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 240 / 255, green: 234 / 255, blue: 220 / 255, alpha: 1)
        selectMonthlyTableView.backgroundColor = UIColor.clear
    }
}

extension SelectMonthlyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return savedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectMonthlyTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectMonthlyTableViewCell
        cell.setupSelectMonthlyVCCell(date: savedDates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMonthlyTableView.deselectRow(at: indexPath, animated: true)
        guard let navigationController = self.navigationController else {
            return
        }
        let balanceBreakdownVC = navigationController.viewControllers[navigationController.viewControllers.count - 2] as! BalanceBreakdownViewController
        balanceBreakdownVC.selectedYear = savedDates[indexPath.row].year
        balanceBreakdownVC.selectedMonth = savedDates[indexPath.row].month
        balanceBreakdownVC.dateType = .selected
        self.navigationController?.popViewController(animated: true)
    }
}
