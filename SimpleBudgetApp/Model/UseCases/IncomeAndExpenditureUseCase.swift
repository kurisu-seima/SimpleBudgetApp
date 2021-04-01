//
//  IncomeAndExpenditureUseCase.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/12.
//

import Foundation
import RealmSwift

class IncomeAndExpenditureUseCase {
    
    static let shared = IncomeAndExpenditureUseCase()
    private let repository = BudgetRepository.shared
    
    private init() {}
    
    func addToday(_ data: IncomeAndExpenditure) {
        guard let daily = repository.getDailyIncomeAndExpenditure(primaryKey: Date().toString) else {
            return
        }
        try! repository.db.write {
            daily.incomeAndExpenditures.append(data)
        }
    }
    
    func addSelected(_ data: IncomeAndExpenditure, date: Date) {
        guard let daily = repository.getDailyIncomeAndExpenditure(primaryKey: date.toString) else {
            return
        }
        try! repository.db.write {
            daily.incomeAndExpenditures.append(data)
        }
    }
}
