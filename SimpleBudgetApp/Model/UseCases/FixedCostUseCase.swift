//
//  FixedCostUseCase.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/02.
//

import Foundation
import RealmSwift

class FixedCostUseCase {
    
    static let shared = FixedCostUseCase()

    var db = try! Realm()

    private init() {

        dayCount = {
            let dateNow = Date()
            let calendar = Calendar(identifier: .gregorian)
            var components = DateComponents()
            components.year = Calendar.current.component(.year, from: dateNow)
            components.month = Calendar.current.component(.month, from: dateNow) + 1
            components.day = 0
            let date = calendar.date(from: components)!
            let dayCount = calendar.component(.day, from: date)
            return dayCount
        }()

        fixedIncomes = {
            return db.objects(FixedIncome.self)
        }()

        fixedSpendings = {
            return db.objects(FixedSpending.self)
        }()

        fixedSavings = {
            return db.objects(FixedSavings.self)
        }()
    }
    
    private (set) var fixedIncomes: Results<FixedIncome>!
    private (set) var fixedSpendings: Results<FixedSpending>!
    private (set) var fixedSavings: Results<FixedSavings>!
    
    private (set) var dayCount: Int
       
    func monthlyFixedIncome() -> Int {
        let amountOfMoneyArray = FixedCostUseCase.shared.fixedIncomes.map({ (fixedIncome: FixedIncome) -> Int in
            if let amountOfMoney = Int(fixedIncome.amountOfMoney) {
                return amountOfMoney
            }
            return 0
        })
        return amountOfMoneyArray.reduce(0){$0 + $1}
    }
    
    func monthlyFixedSpending() -> Int {
        let amountOfMoneyArray = FixedCostUseCase.shared.fixedSpendings.map({ (fixedSpending: FixedSpending) -> Int in
            if let amountOfMoney = Int(fixedSpending.amountOfMoney) {
                return amountOfMoney
            }
            return 0
        })
        return amountOfMoneyArray.reduce(0){$0 + $1}
    }
    
    func monthlyFixedSaving() -> Int {
        let amountOfMoneyArray = FixedCostUseCase.shared.fixedSavings.map({ (fixedSaving: FixedSavings) -> Int in
            if let amountOfMoney = Int(fixedSaving.amountOfMoney) {
                return amountOfMoney
            }
            return 0
        })
        return amountOfMoneyArray.reduce(0){$0 + $1}
    }
    
    func dailyBudget() -> Int {
        let monthlyBudget = monthlyFixedIncome() - (monthlyFixedSpending() + monthlyFixedSaving())
        return monthlyBudget / dayCount
    }
    
    func monthlyBudget() -> Int {
        return monthlyFixedIncome() - (monthlyFixedSpending() + monthlyFixedSaving())
    }
}
