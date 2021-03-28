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
    private let saveDateKey = "SaveDateKey"
    var startDate: String!
    
    var saveDates: [Date] {
        guard let dates = UserDefaults.standard.object(forKey: saveDateKey) as? [Date] else {
            return []
        }
        return dates
    }
    
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
            let dailyAndExpenditure = DailyIncomeAndExpenditure(date: Date())
            saveDateIfNeed(dailyIncomeAndExpenditure: dailyAndExpenditure)
            BudgetRepository.shared.add(dailyAndExpenditure)
            IncomeAndExpenditureUseCase.shared.addToday(IncomeAndExpenditure(details: "一日の予算", amount: "\(MoneyManagementUseCase.shared.getDailyBudget())", plusOrMinus: .plus))
        }
    }
    
    private func saveDateIfNeed(dailyIncomeAndExpenditure: DailyIncomeAndExpenditure) {
        if var dates = UserDefaults.standard.object(forKey: saveDateKey) as? [Date] {
            for date in dates {
                if !(date.year == dailyIncomeAndExpenditure.year && date.month == dailyIncomeAndExpenditure.month) {
                    dates.append(dailyIncomeAndExpenditure.date)
                    UserDefaults.standard.setValue(dates, forKey: saveDateKey)
                }
            }
        } else {
            UserDefaults.standard.setValue([dailyIncomeAndExpenditure.date], forKey: saveDateKey)
        }
    }
}
