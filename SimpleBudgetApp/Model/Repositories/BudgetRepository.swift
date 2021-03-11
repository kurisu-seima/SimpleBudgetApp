//
//  BudgetRepository.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/21.
//

import Foundation
import RealmSwift

class BudgetRepository {
     
    static let shared = BudgetRepository()
    
    var db = try! Realm()
    
    private init() {
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
    
    func fixedIncomesArray() -> [FixedIncome] {
        return Array(BudgetRepository.shared.fixedIncomes)
    }
    
    func fixedSpendingsArray() -> [FixedSpending] {
        return Array(BudgetRepository.shared.fixedSpendings)
    }
    
    func fixedSavingsArray() -> [FixedSavings] {
        return Array(BudgetRepository.shared.fixedSavings)
    }
    
    func add<T: Object>(_ object: T) {
        try! db.write {
            db.add(object)
        }
    }
    
    
}
