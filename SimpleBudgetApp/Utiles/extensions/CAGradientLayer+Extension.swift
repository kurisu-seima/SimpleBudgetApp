//
//  CAGradientLayer+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/09.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    func splashLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 190 / 255, blue: 90 / 255, alpha: 1).cgColor,
            UIColor(red: 1, green: 180 / 255, blue: 0, alpha: 1).cgColor,
            UIColor(red: 1, green: 150 / 255, blue: 0, alpha: 1).cgColor,
            UIColor(red: 1, green: 130 / 255, blue: 0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
     func mainLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 190 / 255, blue: 90 / 255, alpha: 1).cgColor,
            UIColor(red: 1, green: 180 / 255, blue: 0, alpha: 1).cgColor,
            UIColor(red: 1, green: 150 / 255, blue: 0, alpha: 1).cgColor,
            UIColor(red: 1, green: 130 / 255, blue: 0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
     }
    
    func budgetVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 247 / 255, green: 183 / 255, blue: 51 / 255, alpha: 1).cgColor,
            UIColor(red: 252 / 255, green: 95 / 255, blue: 26 / 255, alpha: 1).cgColor,
]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func payDaySettingVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 247 / 255, green: 183 / 255, blue: 51 / 255, alpha: 1).cgColor,
            UIColor(red: 230 / 255, green: 92 / 255, blue: 35 / 255, alpha: 1).cgColor,
]
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    
    func fixedIncomeVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0 / 255, green: 210 / 255, blue: 255 / 255, alpha:  1).cgColor,
            UIColor(red: 58 / 255, green: 123 / 255, blue: 213 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func fixedSpendingVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 255 / 255, green: 140 / 255, blue: 130 / 255, alpha: 1).cgColor,
            UIColor(red: 255 / 255, green: 22 / 255, blue: 26 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func fixedSavingsVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 252 / 255, green: 230 / 255, blue: 120 / 255, alpha: 1).cgColor,
            UIColor(red: 255 / 255, green: 238 / 255, blue: 0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func balanceBreakdoenLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 238 / 255, blue: 238 / 255, alpha: 1).cgColor,
            UIColor(red: 221 / 255, green: 239 / 255, blue: 187 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func monthlyRecordVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor(red: 1, green: 190 / 255, blue: 90 / 255, alpha: 1).cgColor,
                UIColor(red: 1, green: 180 / 255, blue: 0, alpha: 1).cgColor,
                UIColor(red: 1, green: 150 / 255, blue: 0, alpha: 1).cgColor,
                UIColor(red: 1, green: 130 / 255, blue: 0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.frame = frame
        return gradientLayer
    }
}
