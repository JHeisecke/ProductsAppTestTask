//
//  UIView+Extensions.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import UIKit

extension UIView {
   func roundCorners(
      corners: UIRectCorner,
      radius: CGFloat
   ) {
      let path = UIBezierPath(
         roundedRect: bounds,
         byRoundingCorners: corners,
         cornerRadii: CGSize(
            width: radius,
            height: radius
         )
      )

      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
   }
}
