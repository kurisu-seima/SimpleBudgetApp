//
//  MainViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit
import SideMenuSwift

class MainViewController: UIViewController {

    @IBOutlet weak var selectArea: CustomView!
    @IBOutlet weak var selectAreaBottomHight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        guard let navigationController = self.navigationController, (!navigationController.isNavigationBarHidden) else {
            return
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    @IBAction func openInputView(_ sender: Any) {
        selectArea.delegate = self
        selectArea.isHidden = false
        selectAreaBottomHight.constant = 30
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension MainViewController: CustomViewDelegate {
    func closeInpurView() {
        selectArea.isHidden = true
        selectAreaBottomHight.constant = 0
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
