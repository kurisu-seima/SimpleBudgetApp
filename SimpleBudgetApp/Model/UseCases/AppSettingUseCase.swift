//
//  AppSettingUseCase.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/12.
//

import Foundation

class AppSettingUseCase {
    private init() {}
    static let shared = AppSettingUseCase()
    
    private let startDateKey = "StartDateKey"
    var startDate: String!
    
    func sonfigure() {
        saveStartDateIfNeed()
        createDailyIncomeAndExpenditureIfNeed()
    }
    
    private func saveStartDateIfNeed() {
        if let startDate = UserDefaults.standard.value(forKey: startDateKey) as? Date {
            self.startDate = startDate.toString
        } else {
            let now = Date()
            UserDefaults.standard.setValue(now, forKey: startDateKey)
        }
    }
    
    private func createDailyIncomeAndExpenditureIfNeed() {
        if BudgetRepository.shared.getDailyIncomeAndExpenditure(primaryKey: Date().toString) == nil {
            BudgetRepository.shared.add(DailyIncomeAndExpenditure(date: Date()))
            IncomeAndExpenditureUseCase.shared.addToday(IncomeAndExpenditure(details: "一日の予算", amount: "0", plusOrMinus: .plus))
        }
    }
}
