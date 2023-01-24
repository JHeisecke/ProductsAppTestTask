//
//  ProductDetailViewModelTests.swift
//  ProductsAppTestTaskTests
//
//  Created by Javier Heisecke on 2023-01-24.
//

import XCTest
@testable import ProductsAppTestTask

final class ProductDetailViewModelTests: XCTestCase {

    private var viewModel: ProductDetailViewModel!
    
    override func setUpWithError() throws {
        viewModel = ProductDetailViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAddToCart() {
        viewModel.addToCart(product: 0)
        XCTAssertNotEqual(AppData.cart.products, [])
        XCTAssertTrue(viewModel.enableCart.value)
    }
    
    func testClearCart() {
        viewModel.clearCart()
        XCTAssertEqual(AppData.cart.products, [])
        XCTAssertFalse(viewModel.enableCart.value)
    }
    
}
