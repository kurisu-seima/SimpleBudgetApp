//
//  Menu.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/10.
//

import Foundation

enum Menu: CaseIterable {
    case yourMenoy
    case budgetSetting
    case balanceBreakDown
    case monthlyRecord
    
    var label: String {
        switch self {
        case .yourMenoy:
            return "あなたの使えるお金"
        case .budgetSetting:
            return "予算設定"
        case .balanceBreakDown:
            return "収支内訳"
        case .monthlyRecord:
            return "月別記録"
        }
    }
    
    var image: String {
        switch self {
        case .yourMenoy:
            return "graph"
        case .budgetSetting:
            return "money"
        case .balanceBreakDown:
            return "documents"
        case .monthlyRecord:
            return "book"
        }
    }
}
