//
//  HomeViewModelTests.swift
//  ProductsAppTestTaskTests
//
//  Created by Javier Heisecke on 2023-01-24.
//

import XCTest
@testable import ProductsAppTestTask

final class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel!
    private var repository: ProductsRepositoryStub!
    
    override func setUpWithError() throws {
        repository = ProductsRepositoryStub()
        viewModel = HomeViewModel(getProductUseCase: GetProductDetailUseCase(repository: repository), getAllProductsUseCase: GetAllProductsUseCase(repository: repository))
    }

    override func tearDownWithError() throws {
        viewModel = nil
        repository = nil
    }

    func testGetAllProductsWithSuccess() {
        viewModel.getAllProducts()
        XCTAssertNotNil(viewModel.allProducts.value)
    }
    
    func testGetAllProductsWithFailure() {
        repository.hasError = true
        viewModel.getAllProducts()
        XCTAssertNotNil(viewModel.error.value)
    }
    
}
