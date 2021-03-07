//
//  SplashViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/10.
//

import UIKit
import SideMenuSwift

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showMainView()
        }
        
        func showMainView() {
            guard let storyboard = storyboard else {
                return
            }
            SideMenuController.preferences.basic.direction = .left
            SideMenuController.preferences.basic.menuWidth = 280
            let contentViewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
            let navigationController = UINavigationController(rootViewController: contentViewController)
            navigationController.navigationBar.barTintColor = UIColor.orange
            let viewController = SideMenuController(contentViewController: navigationController, menuViewController: menuViewController)
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    
    func backgroundSetUp() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        gradientLayer.colors = [UIColor(red: 1, green: 190 / 255, blue: 90 / 255, alpha: 1).cgColor, UIColor(red: 1, green: 180 / 255, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 150 / 255, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 130 / 255, blue: 0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension Int {
    func numberWithComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        if let result = formatter.string(from: NSNumber(value: self)) {
            return result
        } else {
            return ""
        }
    }
}
