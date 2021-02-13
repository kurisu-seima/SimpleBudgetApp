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
        
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
}
