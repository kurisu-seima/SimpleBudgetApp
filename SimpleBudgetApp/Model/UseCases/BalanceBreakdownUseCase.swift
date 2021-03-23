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
    
    var dailyIncomeAndExpenditures: Results<DailyIncomeAndExpenditure> {
        return repository.dailyIncomeAndExpenditures
    }
    
    func getSelectedMonthDailyIncomeAndExpenditures(year: Int, month: Int) -> [DailyIncomeAndExpenditure] {
        let monthly = dailyIncomeAndExpenditures
//            .filter(NSPredicate(format: "year = 3"))
            .filter(NSPredicate(format: "year = %@", year))
            .filter(NSPredicate(format: "month = %@", month))
            .sorted(byKeyPath: "date", ascending: false)
        return Array(monthly)
    }
    
    func changeDailyBudget() {
        dailyIncomeAndExpenditures.forEach { daily in
            BudgetRepository.shared.write(someting: {
                daily.incomeAndExpenditures[0].amountOfMoney = "\(MoneyManagementUseCase.shared.getDailyBudget())"
            })
        }
    }
}
