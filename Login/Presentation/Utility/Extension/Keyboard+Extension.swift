//
//  Keyboard+Extension.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit

extension UIViewController {
    func keyboardSetNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keboardBoundUp(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardBoundDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keboardBoundUp(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.2) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
            } completion: { _ in
                
            }
        }
    }
    
    @objc func keyboardBoundDown() {
        self.view.transform = .identity
    }
    
}

