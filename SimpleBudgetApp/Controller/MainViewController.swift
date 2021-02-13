//
//  MainViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit
import SideMenuSwift

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        guard let navigationController = self.navigationController, (!navigationController.isNavigationBarHidden) else {
            return
        }
        
        sideMenuController?.revealMenu()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
}
