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
            return db.objects(FixedSaving.self)
        }()
    }
    
    private (set) var fixedIncomes: Results<FixedIncome>!
    private (set) var fixedSpendings: Results<FixedSpending>!
    private (set) var fixedSavings: Results<FixedSaving>!
    
    func fixedIncomesArray() -> [FixedIncome] {
        return Array(BudgetRepository.shared.fixedIncomes)
    }
    
    func fixedSpendingsArray() -> [FixedSpending] {
        return Array(BudgetRepository.shared.fixedSpendings)
    }
    
    func fixedSavingsArray() -> [FixedSaving] {
        return Array(BudgetRepository.shared.fixedSavings)
    }
    
    func addFixedIncome(fixedIncome: FixedIncome) {
        try! db.write {
            db.add(fixedIncome)
        }
    }
    
    func addFixedSpending(fixedSpeding: FixedSpending) {
        try! db.write {
            db.add(fixedSpeding)
        }
    }
    
    func addFixedSaving(fixedSaving: FixedSaving) {
        try! db.write {
            db.add(fixedSaving)
        }
    }
    
    func toDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        let japanDate = dateFormatter.string(from: date)
        return japanDate
    }
}
