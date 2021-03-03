//
//  DailyBalanceOfPayments.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/04.
//

import Foundation
import RealmSwift

class DailyBalanceOfPayments: Object {
    
    @objc dynamic var date = Date()
    @objc dynamic var dailyBalanceOfPayments: [BalancrOfPayments] = []
    
    class BalancrOfPayments: Object {
        
        enum PlusOrMinus {
            case plus
            case minus
        }
        
        @objc dynamic var id = ""
        @objc dynamic var details = ""
        @objc dynamic var amountOfMoney = ""
        
        override static func primaryKey() -> String? {
            return "id"
        }
    }
}
