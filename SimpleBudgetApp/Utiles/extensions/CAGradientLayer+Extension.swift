//
//  CAGradientLayer+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/09.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
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
    
    func fixedIncomeVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 74 / 255, green: 226 / 255, blue: 215 / 255, alpha:  1).cgColor,
            UIColor(red: 170 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func fixedSpendingVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 100 / 255, blue: 100 / 255, alpha: 0.9).cgColor,
            UIColor(red: 1, green: 110 / 255, blue: 110 / 255, alpha: 0.9).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.frame = frame
        return gradientLayer
    }
    
    func fixedSavingsVCLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 240 / 255, blue: 90 / 255, alpha: 1).cgColor,
            UIColor(red: 1, green: 230 / 255, blue: 80 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.frame = frame
        return gradientLayer
    }
}
