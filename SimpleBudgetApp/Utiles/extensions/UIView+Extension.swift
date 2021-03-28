//
//  UIView+Extension.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/03/27.
//

import Foundation
import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        get {
            var parentResponder: UIResponder? = self
            while true {
                guard let nextResponder = parentResponder?.next else { return nil }
                if let viewController = nextResponder as? UIViewController {
                    return viewController
                }
                parentResponder = nextResponder
            }
        }
    }
}
