//
//  UIButton+Extensions.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    enum ButtonState {
        case normal
        case disabled
    }
    
    private var disabledBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if let color = self.defaultBackgroundColor {
                    self.backgroundColor = color
                }
                else {
                    if let color = self.disabledBackgroundColor {
                        self.backgroundColor = color
                    }
                }
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .disabled:
            disabledBackgroundColor = color
        case .normal:
            defaultBackgroundColor = color
        }
    }
}
