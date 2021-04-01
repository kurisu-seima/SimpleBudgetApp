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
            return db.objects(FixedIncome.self).sorted(byKeyPath: "date", ascending: true)
        }()
    
        fixedSpendings = {
            return db.objects(FixedSpending.self).sorted(byKeyPath: "date", ascending: true)
        }()
        
        fixedSavings = {
            return db.objects(FixedSavings.self).sorted(byKeyPath: "date", ascending: true)
        }()
        
        dailyIncomeAndExpenditures = {
            return db.objects(DailyIncomeAndExpenditure.self)
        }()
    }
    
    private (set) var fixedIncomes: Results<FixedIncome>!
    private (set) var fixedSpendings: Results<FixedSpending>!
    private (set) var fixedSavings: Results<FixedSavings>!
    private (set) var dailyIncomeAndExpenditures: Results<DailyIncomeAndExpenditure>!
    
    func getDailyIncomeAndExpenditure(primaryKey: String) -> DailyIncomeAndExpenditure? {
        return db.object(ofType: DailyIncomeAndExpenditure.self, forPrimaryKey: primaryKey)
    }
    
    func addDailyIncomeAndExpenditure(data: DailyIncomeAndExpenditure) {
        try! db.write {
            db.add(data)
        }
    }

    func add<T: Object>(_ object: T) {
        try! db.write {
            db.add(object)
        }
    }
    
    func update<T: Object>(_ object: T) {
        try! db.write {
            db.add(object, update: .all)
        }
    }
    
    func delete<T: Object>(model: T, id: String) {
        let result = db.objects(T.self).filter(NSPredicate(format: "id = %@", id))
        try! db.write {
            db.delete(result)
        }
    }
    
    func write(someting: () -> Void) {
        try! db.write {
            someting()
        }
    }
}
