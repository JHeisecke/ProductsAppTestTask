//
//  UIViewController+Extensions.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import UIKit

extension UIViewController {
    func setRootViewController(_ viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        guard let window = appDelegate.window else {
            appDelegate.window?.rootViewController = viewController
            appDelegate.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)

    }
}