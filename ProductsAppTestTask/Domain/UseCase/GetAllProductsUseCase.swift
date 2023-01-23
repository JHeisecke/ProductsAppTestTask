//
//  GetProductUseCase.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

protocol GetAllProductsUseCaseProtocol {
    func execute(completion: @escaping (ProductsList) -> Void, error: @escaping (ApiError) -> Void)
}

struct GetAllProductsUseCase: GetAllProductsUseCaseProtocol {
    
    private var repository: ProductsRepositoryProtocol?

    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (ProductsList) -> Void, error: @escaping (ApiError) -> Void) {
        repository?.getAllProducts(
            success: { response in
                completion(response)
            },
            failure: { errorResponse in
                error(errorResponse)
            }
        )
    }
}
