//
//  Date+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/08.
//

import Foundation

extension Date {
    
    var currentday: Int {
        let date = Date()
        let calender = Calendar.current
        return calender.component(.day, from: date)
    }
    
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
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMddEEEE", options: 0, locale: nil)
        return dateFormatter.string(from: self)
    }
}


