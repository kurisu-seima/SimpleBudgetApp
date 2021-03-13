//
//  DailyBalanceOfPayments.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/04.
//

import Foundation
import RealmSwift

class DailyIncomeAndExpenditure: Object {

    @objc dynamic var primaryDate: String = ""
    @objc dynamic var date = Date()
    let incomeAndExpenditures = List<IncomeAndExpenditure>()
    
    convenience init(date: Date? = nil) {
        self.init()
        if let date = date {
            self.date = date
        }
        primaryDate = self.date.toString
    }

    override class func primaryKey() -> String? {
        return "primaryDate"
    }
}

class IncomeAndExpenditure: Object {

    enum PlusOrMinus: Int {
        case plus = 0
        case minus = 1
    }

    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var details = ""
    @objc dynamic var amountOfMoney = ""
    @objc dynamic var plusOrMinus = 0

    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(details: String, amount: String, plusOrMinus: PlusOrMinus) {
        self.init()
        self.details = details
        self.amountOfMoney = amount
        self.plusOrMinus = plusOrMinus.rawValue
    }
}
