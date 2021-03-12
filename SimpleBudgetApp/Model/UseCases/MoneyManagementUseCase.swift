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
        return repository.convertArray(type: repository.fixedIncomes)
    }
    
    var fixedSpendings: [FixedSpending] {
        return repository.convertArray(type: repository.fixedSpendings)
    }
    
    var fixedSavings: [FixedSavings] {
        return repository.convertArray(type: repository.fixedSavings)
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
        let totalMonthlyBudget = getTotalAmountOfIncome() - (getTotalAmountOfSpending() - getTotalAmountOfFixedSavings())
        return totalMonthlyBudget / Int().dayCount
    }
    
    func getMonthlyBudget() -> Int {
        return getTotalAmountOfIncome() - (getTotalAmountOfSpending() - getTotalAmountOfFixedSavings())
    }
}

