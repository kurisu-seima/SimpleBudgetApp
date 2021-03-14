//
//  CustomLabel.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/14.
//

import UIKit

class CustomLabel: UILabel {
    
    var startTime: CFTimeInterval!
    
    var fromValue: Int!
    var toValue: Int!
    var duration: TimeInterval!
    
    func animate(from fromValue: Int, to toValue: Int, duration: TimeInterval) {
        text = "¥\(fromValue.numberWithComma())"
        
        self.startTime = CACurrentMediaTime()
        
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        
        let link = CADisplayLink(target: self, selector: #selector(update))
        link.add(to: .current, forMode: .common)
    }
    
    @objc func update(link: CADisplayLink) {
        let dt = (link.timestamp - startTime) / duration
        
        if dt >= 1.0 {
            text = "¥\(toValue.numberWithComma())"
            link.invalidate()
            return
        }
        let current = Int(Double(toValue - fromValue) * dt) + fromValue
        text = "¥\(current.numberWithComma())"
    }
}
