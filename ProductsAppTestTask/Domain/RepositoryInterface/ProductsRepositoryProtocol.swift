//
//  ProductsRepositoryProtocol.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

protocol ProductsRepositoryProtocol {
    func getAllProducts(success: @escaping (ProductsList) -> Void, failure: @escaping (ApiError) -> Void)
    func getProduct(with id: String, success: @escaping (Product) -> Void, failure: @escaping (ApiError) -> Void)
}
