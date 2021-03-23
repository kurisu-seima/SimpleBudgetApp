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
        return Array(repository.fixedIncomes)
    }
    
    var fixedSpendings: [FixedSpending] {
        return Array(repository.fixedSpendings)
    }
    
    var fixedSavings: [FixedSavings] {
        return Array(repository.fixedSavings)
    }
    
    var dailyIncomeAndExpenditures: [DailyIncomeAndExpenditure] {
        return Array(repository.dailyIncomeAndExpenditures)
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
    
    func getDailyBudget() -> Int {
        let totalMonthlyBudget = getTotalAmountOfIncome() - (getTotalAmountOfSpending() + getTotalAmountOfFixedSavings())
        return totalMonthlyBudget / Date().dayCount
    }
    
    func getMonthlyBudget() -> Int {
        return getTotalAmountOfIncome() - (getTotalAmountOfSpending() + getTotalAmountOfFixedSavings())
    }

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
}

