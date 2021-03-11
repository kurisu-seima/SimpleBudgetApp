//
//  Int+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/08.
//

import Foundation

extension Int {
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
    
    //もしかしたらここで日数を取得する？
}
