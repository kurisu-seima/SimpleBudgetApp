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
    
    var thisMonthDailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] {
        return Array(repository.dailyIncomeAndExpenditures
                        .filter(NSPredicate(format: "year = %d", Date().year))
                        .filter(NSPredicate(format: "month = %d", Date().month))
                        .filter(NSPredicate(format: "day = %d", payDay - 1))
                        .filter(NSPredicate(format: "year = %d", Date().year - 1))
                        .filter(NSPredicate(format: "month = %d", Date().month - 1))
                        .filter(NSPredicate(format: "day = %d", payDay...Date().lastDay)))
                        .sorted(byKeyPath: "date", ascending: false))
    }
    
    func getSelectedDailyIncomeAndExpenditures(year: Int, month: Int) -> [DailyIncomeAndExpenditure] {
        let monthly = repository.dailyIncomeAndExpenditures
            .filter(NSPredicate(format: "year = %d", Date().year))
            .filter(NSPredicate(format: "month = %d", Date().month))
            .filter(NSPredicate(format: "day = %d", payDay - 1))
            .filter(NSPredicate(format: "year = %d", Date().year - 1))
            .filter(NSPredicate(format: "month = %d", Date().month - 1))
            .filter(NSPredicate(format: "day = %d", payDay...Date().lastDay)))
            .sorted(byKeyPath: "date", ascending: false)
        return Array(monthly)
    }
    
    func saveDailyBudget() {
        thisMonthDailyIncomeAndExpenditures.forEach { daily in
            BudgetRepository.shared.write(someting: {
                daily.incomeAndExpenditures[0].amountOfMoney = "\(MoneyManagementUseCase.shared.getDailyBudget())"
            })
        }
    }
}
