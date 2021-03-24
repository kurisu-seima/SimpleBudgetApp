//
//  BalanceBreakdownUseCase.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/22.
//

import Foundation
import RealmSwift

class BalanceBreakdownUseCase {

    static let shared = BalanceBreakdownUseCase()
    private let repository = BudgetRepository.shared

    private init() {}
    
    //すべてのDailyIncomeAndExpenditureを取得する
   private var dailyIncomeAndExpenditures: Results<DailyIncomeAndExpenditure> {
        return repository.dailyIncomeAndExpenditures
    }
    
    //今月のDailyIncomeAndExpenditureを取得する
    var thisMonthDailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] {
        return Array(dailyIncomeAndExpenditures
                        .filter(NSPredicate(format: "year = 3"))
//                        .filter(NSPredicate(format: "year = %@", Date().year))
//                        .filter(NSPredicate(format: "month = %@", Date().month))
                        .sorted(byKeyPath: "date", ascending: false))
    }
    
    //指定された月のDailyIncomeAndExpenditureを取得する
    func getSelectedMonthDailyIncomeAndExpenditures(year: Int, month: Int) -> [DailyIncomeAndExpenditure] {
        let monthly = dailyIncomeAndExpenditures
            .filter(NSPredicate(format: "year = %@", year))
            .filter(NSPredicate(format: "month = %@", month))
            .sorted(byKeyPath: "date", ascending: false)
        return Array(monthly)
    }
    
    //一日あたりの予算が変わった時に今月のIncomeAndExpendituresの0番目の要素の金額も変更する
    func changeDailyBudget() {
        thisMonthDailyIncomeAndExpenditures.forEach { daily in
            BudgetRepository.shared.write(someting: {
                daily.incomeAndExpenditures[0].amountOfMoney = "\(MoneyManagementUseCase.shared.getDailyBudget())"
            })
        }
    }
}
