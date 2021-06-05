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
    private let savePaydayKey = "PayDayKey"
    
    var startDate: String!
    
    var savedDates: [Date] {
        return UserDefaults.standard.object(forKey: saveDateKey) as! [Date]
    }
    
    var payday: String {
        get {
            UserDefaults.standard.string(forKey: savePaydayKey) ?? "1"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: savePaydayKey)
        }
    }
    
    func sonfigure() {
        createDailyIncomeAndExpenditureIfNeed()
        saveStartDateIfNeed()
        saveDateIfNeed()
    }
    
    private func saveStartDateIfNeed() {
        if let startDate = UserDefaults.standard.value(forKey: startDateKey) as? Date {
            self.startDate = startDate.toString
        } else {
            let now = Date()
            UserDefaults.standard.setValue(now, forKey: startDateKey)
        }
    }
    
    private func saveDateIfNeed() {
        if var saveDates = UserDefaults.standard.object(forKey: saveDateKey) as? [Date] {
            if !(saveDates.last?.year == Date().year && saveDates.last?.month == Date().month) {
                saveDates.append(Date())
                UserDefaults.standard.setValue(saveDates, forKey: saveDateKey)
            }
        } else {
            UserDefaults.standard.setValue([Date()], forKey: saveDateKey)
        }
    }
    
    func createDailyIncomeAndExpenditureIfNeed() {
        if BudgetRepository.shared.getDailyIncomeAndExpenditure(primaryKey: Date().toString) == nil {
            BudgetRepository.shared.addDailyIncomeAndExpenditure(data: DailyIncomeAndExpenditure(date: Date()))
            IncomeAndExpenditureUseCase.shared.addToday(IncomeAndExpenditure(details: "一日の予算", amount: "\(MoneyManagementUseCase.shared.getDailyBudget())", plusOrMinus: .plus))
        }
    }
}
