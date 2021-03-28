//
//  BalanceBreakdownManagementUseCase.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/24.
//

import Foundation
import RealmSwift

class BalanceBreakdownManagementUseCase {
    
    static let shared = BalanceBreakdownManagementUseCase()
    private let repository = BudgetRepository.shared

    private init() {}
    
    //すべてのDailyIncomeAndExpenditureを取得する
   private var dailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] {
        return Array(repository.dailyIncomeAndExpenditures)
    }
    
    //今月のDailyIncomeAndExpenditureを取得する
    var thisMonthDailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] {
        return Array(repository.dailyIncomeAndExpenditures
                        .filter(NSPredicate(format: "year = %d", Date().year))
                        .filter(NSPredicate(format: "month = %d", Date().month))
                        .sorted(byKeyPath: "date", ascending: false))
    }
    
    //指定された月のDailyIncomeAndExpenditureを取得する
    func getSelectedDailyIncomeAndExpenditures(year: Int, month: Int) -> [DailyIncomeAndExpenditure] {
        let monthly = repository.dailyIncomeAndExpenditures
            .filter(NSPredicate(format: "year = %d", year))
            .filter(NSPredicate(format: "month = %d", month))
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
