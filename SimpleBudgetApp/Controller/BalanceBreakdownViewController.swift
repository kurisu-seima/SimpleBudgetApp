//
//  BalanceBreakdownViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit

class BalanceBreakdownViewController: UIViewController {
    
    @IBOutlet weak var balanceBreakdownTableView: UITableView!

    let dateOfBreakdwon = ["2021年2月18日", "2021年2月19日", "2021年2月20日"]
    let item = [["お小遣い", "仕事", "散財"], ["バイト", "バイト", "バイト"], ["食べ物", "飲み物", "ポテチ"]]
    let amount = [["100", "200", "300"], ["400", "500", "600"], ["700", "800", "900"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        balanceBreakdownTableView.dataSource = self
        balanceBreakdownTableView.delegate = self
    }
}

extension BalanceBreakdownViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        item.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateOfBreakdwon[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = balanceBreakdownTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.setUp(item: item[indexPath.section][indexPath.row], amount: amount[indexPath.section][indexPath.row])
        return cell
    }
}
