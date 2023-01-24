//
//  ProductCollectionViewCell.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import Foundation
import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        setupUI()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor(named: "brand-background")?.cgColor
        self.layer.borderWidth = 1
    }
    
    func configure(product: Product) {
        let url = URL(string: product.image!)
        KF.url(url)
            .placeholder(UIImage(named: "store-placeholder"))
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .set(to: image)
        title.text = product.title?.capitalized
        price.text = "$\(product.price ?? 0)"
        category.text = product.category?.rawValue.capitalized
        
    }
}
