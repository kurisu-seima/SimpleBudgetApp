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
}


