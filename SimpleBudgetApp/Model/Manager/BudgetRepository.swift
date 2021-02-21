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
    
    private init() {
        fixedIncomes = {
            let realm = try! Realm()
            return realm.objects(FixedIncome.self)
        }()
    }
    
    private (set) var fixedIncomes: Results<FixedIncome>!
    
    func addFixedIncome(fixedIncome: FixedIncome) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(fixedIncome)
        }
    }
}
