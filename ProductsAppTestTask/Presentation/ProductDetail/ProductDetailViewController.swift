//
//  ProductDetailViewController.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product else { return }
        setupUI(for: product)
    }
}

private extension ProductDetailViewController {
    func setupUI(for product: Product) {
        title = product.category?.rawValue
        productDescription.text = product.description
        productPrice.text = "$\(product.price ?? 0)"
        productTitle.text = product.title
        addToCartButton.layer.cornerRadius = 10
        if let rate = product.rating?.rate {
            ratingView.layer.cornerRadius = 10
            ratingView.layer.shadowColor = UIColor.black.cgColor
            ratingView.layer.shadowRadius = 5
            ratingView.layer.shadowOffset = .zero
            ratingView.layer.shadowOpacity = 0.2
            ratingLabel.text = "\(rate)"
        } else {
            ratingView.isHidden = true
        }
        guard let url = URL(string: product.image ?? "") else { return }
        KF.url(url)
            .placeholder(UIImage(named: "store-placeholder"))
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .set(to: productImage)
        
    }
}
