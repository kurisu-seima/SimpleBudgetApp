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
    }
    
    private (set) var fixedIncomes: Results<FixedIncome>!
    
    func fixedIncomesArray() -> [FixedIncome] {
        return Array(BudgetRepository.shared.fixedIncomes)
    }
    
    func addFixedIncome(fixedIncome: FixedIncome) {
        try! db.write {
            db.add(fixedIncome)
        }
    }
    
    func toDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        let japanDate = dateFormatter.string(from: date)
        return japanDate
    }
}