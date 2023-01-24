//
//  CustomButton.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    override open var isEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if self.isEnabled {
                    self.backgroundColor = UIColor(named: "brand-foreground")
                }
                else {
                    self.backgroundColor = UIColor(named: "disabled-button")
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isEnabled {
            self.backgroundColor = UIColor(named: "brand-foreground")
        }
        self.imageView?.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
    }
}

