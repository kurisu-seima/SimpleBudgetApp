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
        
        layerColorSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppSettingUseCase.shared.sonfigure()
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
    
    private func layerColorSetUp() {
        self.view.layer.insertSublayer(CAGradientLayer().mainLayer(frame: self.view.frame), at: 0)
    }
}
