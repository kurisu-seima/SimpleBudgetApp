//
//  MonthlyRecordViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class MonthlyRecordViewController: UIViewController {

    @IBOutlet weak var monthlyRecordTableView: UITableView!
    
    let num = ["2020", "2021", "2022"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        monthlyRecordTableView.dataSource = self
        monthlyRecordTableView.delegate = self
    }
}

extension MonthlyRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        num.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = monthlyRecordTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
