//
//  UIColor+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/09.
//

import Foundation
import UIKit

extension UIColor {
    
    var fixedIncomeVCNavigationColor: UIColor {
        return UIColor(red: 170 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1)
    }
    
    var fixedSpendingVCNavigationColor: UIColor {
        return UIColor(red: 1, green: 120 / 255, blue: 120 / 255, alpha: 0.9)
    }
    
    var fixedSavingsVCNavigationColor: UIColor {
        return UIColor(red: 1, green: 235 / 255, blue: 80 / 255, alpha: 1)
    }
    
    var incomeStartColor: UIColor {
        return UIColor(red: 71 / 255, green: 193 / 255, blue: 227 / 255, alpha: 1)
    }
    
    var incomeEndColor: UIColor {
        return UIColor(red: 72 / 255, green: 239 / 255, blue: 236 / 255, alpha: 1)
    }
    
    var spendingStartColor: UIColor {
        return UIColor(red: 1, green: 86 / 255, blue: 107 / 255, alpha: 1)
    }
    
    var spendingEndColor: UIColor {
        return UIColor(red: 1, green: 201 / 255, blue: 189 / 255, alpha: 1)
    }
    
    var savingsStartColor: UIColor {
        return UIColor(red: 1, green: 215 / 255, blue: 0, alpha: 1)
    }
    
    var savingsEndColor: UIColor {
        return UIColor(red: 248 / 255, green: 1, blue: 201 / 255, alpha: 1)
    }
}
