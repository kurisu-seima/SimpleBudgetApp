//
//  FixedSavings.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/09.
//

import Foundation
import RealmSwift

class FixedSavings: Object {
    
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var date = Date()
    @objc dynamic var details: String = ""
    @objc dynamic var amountOfMoney: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
