//
//  MainViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/02/07.
//

import UIKit
import SideMenuSwift

class MainViewController: UIViewController {

    @IBOutlet weak var monthlyBudgetLabel: UILabel!
    @IBOutlet weak var dailyLimitLabel: UILabel!
    @IBOutlet weak var selectArea: CustomView!
    
    var addButtonTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        backgroundSetUp()
        labelSetUp()

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
    
    @IBAction func openInputView(_ sender: UIButton) {
        selectArea.delegate = self
        addButtonTag = sender.tag
        selectArea.isHidden = false
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func labelSetUp() {
        monthlyBudgetLabel.text = "¥\(FixedCostUseCase.shared.monthlyBudget().numberWithComma())"
    }
    
    func backgroundSetUp() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        gradientLayer.colors = [UIColor(red: 1, green: 190 / 255, blue: 90 / 255, alpha: 1).cgColor, UIColor(red: 1, green: 180 / 255, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 150 / 255, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 130 / 255, blue: 0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
//    func backgroundSetUp() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//        gradientLayer.colors = [UIColor.systemOrange.cgColor, UIColor(red: 1, green: 220 / 255, blue: 50 / 255, alpha: 1).cgColor, UIColor(red: 1, green: 220 / 255, blue: 50 / 255, alpha: 1).cgColor, UIColor.systemOrange.cgColor, UIColor(red: 1, green: 220 / 255, blue: 50 / 255, alpha: 1).cgColor, UIColor.systemOrange.cgColor]
//        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
}

extension MainViewController: CustomViewDelegate {
    var addButtonTagCount: Int {
        return addButtonTag
    }
    
    func closeInputView() {
        selectArea.isHidden = true
        selectArea.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0).isActive = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
