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
        
        dailyIncomeAndExpenditures = {
            return db.objects(DailyIncomeAndExpenditure.self)
        }()
    }
    
    private (set) var fixedIncomes: Results<FixedIncome>!
    private (set) var fixedSpendings: Results<FixedSpending>!
    private (set) var fixedSavings: Results<FixedSavings>!
    private (set) var dailyIncomeAndExpenditures: Results<DailyIncomeAndExpenditure>!
    
    func convertArray<T: Object>(type: Results<T>) -> [T] {
        return Array(type)
    }

    func add<T: Object>(_ object: T) {
        try! db.write {
            db.add(object)
        }
    }
}
