//
//  ProductDetailViewController.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import UIKit
import Kingfisher
import Bond

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var productDetailsView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var addToCartButton: CustomButton!
    
    var viewModel: ProductDetailViewModelProtocol?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let product else { return }
        setupUI(for: product)
        setupObservables()
    }
    
    @objc func clearCart() {
        self.simpleAlert(
            title: "Clear Cart",
            message: "You will be removing \(AppData.cart.products.count) products off you cart",
            completion: { [weak self] _ in
                guard let self else { return }
                self.viewModel?.clearCart()
            }
        )
    }
}

private extension ProductDetailViewController {
    func setupUI(for product: Product) {
        title = product.category?.rawValue.capitalized
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "cart"), style: .plain, target: self, action: #selector(clearCart))
        productDetailsView.layer.cornerRadius = 20
        productDetailsView.layer.shadowColor = UIColor.black.cgColor
        productDetailsView.layer.shadowRadius = 4.0
        productDetailsView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        productDetailsView.layer.shadowOpacity = 0.2
        setupProductDetails(for: product)
    }
    
    func setupProductDetails(for product: Product) {
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
    
    func setupObservables() {
        
        viewModel?.enableCart.bind(to: navigationItem.rightBarButtonItem!.reactive.isEnabled)
        
        addToCartButton.reactive.tap.observeNext { [weak self] _ in
            guard let self, let productId = self.product?.id else { return }
            self.viewModel?.addToCart(product: productId)
        }.dispose(in: bag)
    }
}
