//
//  FixedSpending.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/21.
//

import Foundation
import RealmSwift

class FixedSpending: Object {
    
   @objc dynamic var details: String = ""
   @objc dynamic var amountOfMoney: String = ""
    
}
