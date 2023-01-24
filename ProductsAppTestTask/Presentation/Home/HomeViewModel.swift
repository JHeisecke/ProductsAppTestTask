//
//  HomeViewModel.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation
import Bond
import ReactiveKit

protocol HomeViewModelProtocol {
    func getAllProducts()
    var allProducts: Observable<ProductsList?> { get }
    var product: Observable<Product?> { get }
    var error: Observable<ApiError?> { get }
}

struct HomeViewModel: HomeViewModelProtocol {
    
    private let getProductUseCase: GetProductDetailUseCaseProtocol
    private let getAllProductsUseCase: GetAllProductsUseCaseProtocol
    
    var bag: DisposeBag = DisposeBag()
    var allProducts: Observable<ProductsList?> = Observable(nil)
    var product: Observable<Product?> = Observable(nil)
    var error: Observable<ApiError?> = Observable(nil)

    init(getProductUseCase: GetProductDetailUseCaseProtocol, getAllProductsUseCase: GetAllProductsUseCaseProtocol) {
        self.getProductUseCase = getProductUseCase
        self.getAllProductsUseCase = getAllProductsUseCase
    }
    
    func getAllProducts() {
        getAllProductsUseCase.execute { productList in
            self.allProducts.value = productList
        } error: { apiError in
            self.error.value = apiError
        }
    }
    
}
