//
//  ProductDetailViewModel.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import Foundation
import Bond

protocol ProductDetailViewModelProtocol {
    var enableCart: Observable<Bool> { get }
    
    func addToCart(product id: Int)
    func clearCart()
}

struct ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    var enableCart: Observable<Bool> = Observable(AppData.cart.products.count > 0)
    
    func addToCart(product id: Int) {
        AppData.cart.products.append(id)
        enableCart.value = true
    }
    
    func clearCart() {
        AppData.cart = Cart()
        enableCart.value = false
    }
}
