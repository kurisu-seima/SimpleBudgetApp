//
//  DailyBalanceOfPayments.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/04.
//

import Foundation
import RealmSwift

class DailyBalanceOfPayments: Object {

    @objc dynamic var date = dateSetUp()
//    let dailyBalanceOfPayments: List<BalanceOfPayments> = List<BalanceOfPayments>()

    static func dateSetUp() -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMddEEEE", options: 0, locale: Locale(identifier: "ja_JP"))
        let jpDateString = dateFormatter.string(from: date)
        guard let jp_Date = dateFormatter.date(from: jpDateString) else { return date }
        return jp_Date
    }

//    class BalanceOfPayments: Object {
//
//        enum PlusOrMinus: Int {
//            case plus = 0
//            case minus = 1
//        }
//
//        @objc dynamic var id = NSUUID().uuidString
//        @objc dynamic var details = ""
//        @objc dynamic var amountOfMoney = ""
//        @objc dynamic var plusOrMinus = 0
//
//        override static func primaryKey() -> String? {
//            return "id"
//        }
//    }
}
