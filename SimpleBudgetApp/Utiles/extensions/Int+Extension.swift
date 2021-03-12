//
//  Int+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/08.
//

import Foundation

extension Int {
    
    var dayCount: Int {
        let dateNow = Date()
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: dateNow)
        components.month = Calendar.current.component(.month, from: dateNow) + 1
        components.day = 0
        let date = calendar.date(from: components)!
        let dayCount = calendar.component(.day, from: date)
        return dayCount
    }
    
    
    func numberWithComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        guard let result = formatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        return result
    }
}
