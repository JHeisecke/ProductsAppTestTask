//
//  ProductsRepository.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

struct ProductsRepository: ProductsRepositoryProtocol {
    
    var api: ApiClient?

    init(api: ApiClient) {
        self.api = api
    }
    
    func getAllProducts(success: @escaping (ProductsList) -> Void, failure: @escaping (ApiError) -> Void) {
        api?.request(
            verb: .get,
            route: Endpoints.GET_products(),
            encoding: .default) { (response: ProductsList) in
                success(response)
            } failure: { error in
                failure(error)
            }
    }
    
    func getProduct(with id: String, success: @escaping (Product) -> Void, failure: @escaping (ApiError) -> Void) {
        api?.request(
            verb: .get,
            route: Endpoints.GET_product(with: id),
            encoding: .default) { (response: Product) in
                success(response)
            } failure: { error in
                failure(error)
            }
    }
}
