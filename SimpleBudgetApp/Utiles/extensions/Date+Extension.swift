//
//  Date+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/08.
//

import Foundation

extension Date {
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMddEEEE", options: 0, locale: nil)
        return dateFormatter.string(from: self)
    }
    
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar(identifier: .japanese).component(.day, from: self)
    }
    
    var lastDay: Int {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: self)
        components.month = Calendar.current.component(.month, from: self) + 1
        components.day = 0
        let date = calendar.date(from: components)!
        let dayCount = calendar.component(.day, from: date)
        return dayCount
    }
}


