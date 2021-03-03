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
        
        // Do any additional setup after loading the view.
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
