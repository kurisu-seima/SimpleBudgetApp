//
//  MoneyManagementUseCase.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/11.
//

import Foundation
import RealmSwift

class MoneyManagementUseCase {
    
    static let shared = MoneyManagementUseCase()
    private let repository = BudgetRepository.shared
    
    private init() {}
    
    var fixedIncomes: [FixedIncome] {
        return Array(repository.fixedIncomes
                        .filter(NSPredicate(format: "year = %d", Date().year))
                        .filter(NSPredicate(format: "month = %d", Date().month)))
    }
    
    var fixedSpendings: [FixedSpending] {
        return Array(repository.fixedSpendings
                        .filter(NSPredicate(format: "year = %d", Date().year))
                        .filter(NSPredicate(format: "month = %d", Date().month)))
    }
    
    var fixedSavings: [FixedSavings] {
        return Array(repository.fixedSavings
                        .filter(NSPredicate(format: "year = %d", Date().year))
                        .filter(NSPredicate(format: "month = %d", Date().month)))
    }
    
    var dailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] {
        return Array(repository.dailyIncomeAndExpenditures
                        .filter(NSPredicate(format: "year = %d", Date().year))
                        .filter(NSPredicate(format: "month = %d", Date().month)))
    }
    
    func getTotalAmountOfIncome() -> Int {
        return fixedIncomes.map {(element) -> Int in
            guard let amountArray = Int(element.amountOfMoney) else {
                return 0
            }
            return amountArray
        }.reduce(0) {$0 + $1}
    }
    
    func getTotalAmountOfSpending() -> Int {
        return fixedSpendings.map {(element) -> Int in
            guard let amountArray = Int(element.amountOfMoney) else {
                return 0
            }
            return amountArray
        }.reduce(0) {$0 + $1}
    }
    
    func getTotalAmountOfFixedSavings() -> Int {
        return fixedSavings.map {(element) -> Int in
            guard let amountArray = Int(element.amountOfMoney) else {
                return 0
            }
            return amountArray
        }.reduce(0) {$0 + $1}
    }
    
    //一日あたりの予算
    func getDailyBudget() -> Int {
        let totalMonthlyBudget = getTotalAmountOfIncome() - (getTotalAmountOfSpending() + getTotalAmountOfFixedSavings())
        return totalMonthlyBudget / Date().lastDay
    }
    
    //一ヶ月間の予算
    func getMonthlyBudget() -> Int {
        return getTotalAmountOfIncome() - (getTotalAmountOfSpending() + getTotalAmountOfFixedSavings())
    }

    //今日使える予算
    func getTodayBudget() -> Int {
        var totalAmount: Int = 0
        dailyIncomeAndExpenditures.forEach { daily in
         let dailyAmount = daily.incomeAndExpenditures.map {(element: IncomeAndExpenditure) -> Int in
                guard let incomeAndExpenditure = IncomeAndExpenditure.PlusOrMinus(rawValue: element.plusOrMinus) else {
                    return 0
                }
                switch incomeAndExpenditure {
                case .plus:
                    guard let income = Int(element.amountOfMoney) else {
                        return 0
                    }
                    return income
                case .minus:
                    guard let spending = Int(element.amountOfMoney) else {
                        return 0
                    }
                    return spending * -1
                }}.reduce(0) {$0 + $1}
            totalAmount += dailyAmount
        }
        return totalAmount
    }
    
    //指定された月の一日の収支の合計
    func getDailyTotalAmounts(dailyIncomeAndExpenditures: [DailyIncomeAndExpenditure]) -> [Int] {
        var dailyTotalAmounts: [Int] = []
        dailyIncomeAndExpenditures.forEach { daily in
            let total = daily.incomeAndExpenditures.map { (element: IncomeAndExpenditure) -> Int in
                guard let incomeAndExpenditure = IncomeAndExpenditure.PlusOrMinus(rawValue: element.plusOrMinus) else {
                    return 0
                }
                switch incomeAndExpenditure {
                case .plus:
                    guard let income = Int(element.amountOfMoney) else {
                        return 0
                    }
                    return income
                case .minus:
                    guard let spending = Int(element.amountOfMoney) else {
                        return 0
                    }
                    return spending * -1
                }
            }.reduce(0) {$0 + $1}
            dailyTotalAmounts.append(total)
        }
        return dailyTotalAmounts
    }
    
    //月別の固定収入の合計を保持
    var getMonthlyFixedIncomesAmounts: [Int] {
        var totals: [Int] = []
        for date in AppSettingUseCase.shared.savedDates.sorted(by: >) {
            let fixedIncomes = Array(repository.fixedIncomes
                                        .filter(NSPredicate(format: "year = %d", date.year))
                                        .filter(NSPredicate(format: "month = %d", date.month)))
            let dailyAmount = fixedIncomes.map { fixedIncome -> Int in
                guard let fixedIncomeAmount = Int(fixedIncome.amountOfMoney) else {
                    return 0
                }
                return fixedIncomeAmount
            }.reduce(0) { $0 + $1}
            totals.append(dailyAmount)
        }
        return totals
    }
    
    //月別の固定支出の合計を保持
    var getMonthlyFixedSpendingsAmounts: [Int] {
        var totals: [Int] = []
        for date in AppSettingUseCase.shared.savedDates.sorted(by: >) {
            let fixedSpendings = Array(repository.fixedSpendings
                                        .filter(NSPredicate(format: "year = %d", date.year))
                                        .filter(NSPredicate(format: "month = %d", date.month)))
            let dailyAmount = fixedSpendings.map { fixedSpending -> Int in
                guard let fixedSpendingAmount = Int(fixedSpending.amountOfMoney) else {
                    return 0
                }
                return fixedSpendingAmount
            }.reduce(0) { $0 + $1}
            totals.append(dailyAmount)
        }
        return totals
    }
    
    //月別の固定貯金の合計を保持
    var getMonthlyFixedSavingsAmounts: [Int] {
        var totals: [Int] = []
        for date in AppSettingUseCase.shared.savedDates.sorted(by: >) {
            let fixedSavings = Array(repository.fixedSavings
                                        .filter(NSPredicate(format: "year = %d", date.year))
                                        .filter(NSPredicate(format: "month = %d", date.month)))
            let dailyAmount = fixedSavings.map { fixedSavings -> Int in
                guard let fixedfixedSavingsAmount = Int(fixedSavings.amountOfMoney) else {
                    return 0
                }
                return fixedfixedSavingsAmount
            }.reduce(0) { $0 + $1}
            totals.append(dailyAmount)
        }
        return totals
    }
    
    //月別の臨時収入の合計を保持
    var getMonthlyExtraordinaryIncomeAmounts: [Int] {
        var totals: [Int] = []
        for date in AppSettingUseCase.shared.savedDates.sorted(by: >) {
            var monthly: [Int] = []
            let dailyIncomeAndExpenditures = Array(repository.dailyIncomeAndExpenditures
                                                    .filter(NSPredicate(format: "year = %d", date.year))
                                                    .filter(NSPredicate(format: "month = %d", date.month)))
            dailyIncomeAndExpenditures.forEach { daily in
                let dailyAmount = daily.incomeAndExpenditures.map { element -> Int in
                    guard let plusOrMinus = IncomeAndExpenditure.PlusOrMinus(rawValue: element.plusOrMinus) else {
                        return 0
                    }
                    switch plusOrMinus {
                    case .plus:
                        guard let income = Int(element.amountOfMoney) else {
                            return 0
                        }
                        switch income {
                        case MoneyManagementUseCase.shared.getDailyBudget():
                            return 0
                        default:
                            return income
                        }
                    case .minus:
                        return 0
                    }
                }.reduce(0) {$0 + $1}
                monthly.append(dailyAmount)
            }
            totals.append(monthly.reduce(0) {$0 + $1})
        }
        return totals
    }
    
    //月別の臨時支出の合計を保持
    var getMonthlyExtraordinarySpendingAmounts: [Int] {
        var totals: [Int] = []
        for date in AppSettingUseCase.shared.savedDates.sorted(by: >) {
            var monthly: [Int] = []
            let dailyIncomeAndExpenditures = Array(repository.dailyIncomeAndExpenditures
                                                    .filter(NSPredicate(format: "year = %d", date.year))
                                                    .filter(NSPredicate(format: "month = %d", date.month)))
            dailyIncomeAndExpenditures.forEach { daily in
                let dailyAmount = daily.incomeAndExpenditures.map { element -> Int in
                    guard let plusOrMinus = IncomeAndExpenditure.PlusOrMinus(rawValue: element.plusOrMinus) else {
                        return 0
                    }
                    switch plusOrMinus {
                    case .plus:
                        return 0
                    case .minus:
                        guard let spending = Int(element.amountOfMoney) else {
                            return 0
                        }
                        return spending
                    }
                }.reduce(0) {$0 + $1}
                monthly.append(dailyAmount)
            }
            totals.append(monthly.reduce(0) {$0 + $1})
        }
        return totals
    }
}
