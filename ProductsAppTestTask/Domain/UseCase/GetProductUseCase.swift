//
//  GetProductUseCase.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

protocol GetProductDetailUseCaseProtocol {
    func execute(with productId: String, completion: @escaping (Product) -> Void, error: @escaping (ApiError) -> Void)
}

struct GetProductDetailUseCase: GetProductDetailUseCaseProtocol {
    
    private var repository: ProductsRepositoryProtocol?

    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(with productId: String, completion: @escaping (Product) -> Void, error: @escaping (ApiError) -> Void) {
        repository?.getProduct(with: productId,
            success: { response in
                completion(response)
            },
            failure: { errorResponse in
                error(errorResponse)
            }
        )
    }
}
