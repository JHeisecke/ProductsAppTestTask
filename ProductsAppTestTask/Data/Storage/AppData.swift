//
//  AppData.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-24.
//

import Foundation

// MARK: - User Defaults Handler
struct AppData {
    @Storage(key: UserDefaultsKeys.cart, defaultValue: Cart())
    static var cart: Cart
}

extension AppData {
    static func clear() {
        cart = Cart()
    }
}

// MARK: - User Defaults Keys
struct UserDefaultsKeys {
    static let cart = "Cart"
}
