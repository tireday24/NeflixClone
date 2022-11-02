//
//  BaseViewController.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
        tapGesture()
    }
    
    func configure() {
       
    }
    
    func setConstraints() {
        
    }
    
    func tapGesture() {
        
    }
    
    func showAlert(title: String, message: String ,button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
