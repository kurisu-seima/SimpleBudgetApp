//
//  PayDaySettingViewController.swift
//  SimpleBudgetApp
//
//  Created by 栗須星舞 on 2021/05/19.
//

import UIKit

class PayDaySettingViewController: UIViewController {

    @IBOutlet weak var selectArea: InputView!
    @IBOutlet weak var selectAreaTop: NSLayoutConstraint!
    @IBOutlet weak var selectAreaHeight: NSLayoutConstraint!
    @IBOutlet weak var paDayLabel: UILabel!
    @IBOutlet weak var payDayNumber: UILabel!
    @IBOutlet weak var changeButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupView()
        setupPayDay()
    }
    
    @IBAction func changeButtonDidTapped(_ sender: UIButton) {
        selectArea.delegate = self
        selectArea.isHidden = false
        selectAreaTop.constant = 50
        selectAreaHeight.constant = 900
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 1
            paDayLabel.alpha = 0
            payDayNumber.alpha = 0
            changeButton.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupView() {
        self.overrideUserInterfaceStyle = .light
        self.view.layer.insertSublayer(CAGradientLayer().payDaySettingVCLayer(frame: self.view.frame), at: 0)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupPayDay() {
        payDayNumber.text = AppSettingUseCase.shared.payday
    }
}

extension PayDaySettingViewController: InputViewDelegate {
    func didFinish(details: String, amount: String) {
        AppSettingUseCase.shared.payday = amount
        setupPayDay()
    }
    
    func closeInputView() {
        selectAreaHeight.constant = 0
        selectAreaTop.constant = 900
        UIView.animate(withDuration: 0.3) { [self] in
            guard let view = selectArea.subviews.first else { return }
            view.alpha = 0
            paDayLabel.alpha = 1
            payDayNumber.alpha = 1
            changeButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}
