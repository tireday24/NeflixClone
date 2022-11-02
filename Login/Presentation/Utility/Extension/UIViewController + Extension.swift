//
//  UIViewController + Extension.swift
//  Login
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit

extension UIViewController {
    enum Transiton {
        case push
        case present
        case presentFullScreen
        case popup
        case presentNavigation
    }
    
    func transition<T: UIViewController>(_ viewController: T, trasionStyle: Transiton) {
        
        switch trasionStyle {
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            self.present(viewController, animated: true)
        case .presentFullScreen:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .popup:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .overCurrentContext
            self.present(navi, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        }
    }
}
