//
//  ProductsRepositoryStub.swift
//  ProductsAppTestTaskTests
//
//  Created by Javier Heisecke on 2023-01-24.
//

import Foundation
@testable import ProductsAppTestTask

class ProductsRepositoryStub: ProductsRepositoryProtocol {

    var hasError = false

    func getAllProducts(success: @escaping (ProductsList) -> Void, failure: @escaping (ApiError) -> Void) {
        if hasError {
            failure(ApiError(message: "Error"))
        } else {
            success([])
        }
    }
    
    func getProduct(with id: String, success: @escaping (Product) -> Void, failure: @escaping (ApiError) -> Void) {
        if hasError {
            failure(ApiError(message: "Error"))
        } else {
            success(Product(id: 0, title: "", price: 0, description: "", category: nil, image: nil, rating: nil))
        }
    }
    
}
