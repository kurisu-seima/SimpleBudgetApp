//
//  PayDaySettingViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/05/19.
//

import UIKit

class PayDaySettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupView()
    }
    
    private func setupView() {
        self.view.layer.insertSublayer(CAGradientLayer().payDaySettingVCLayer(frame: self.view.frame), at: 0)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
