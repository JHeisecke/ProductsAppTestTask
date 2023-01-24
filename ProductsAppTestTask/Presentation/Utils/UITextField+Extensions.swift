//
//  UITextField+Extensions.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Combine
import UIKit

extension UITextField {
    
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { notification in
            guard let textField = notification.object as? UITextField else {
                return nil
            }
            return textField.text
        }
        .eraseToAnyPublisher()
    }
}
