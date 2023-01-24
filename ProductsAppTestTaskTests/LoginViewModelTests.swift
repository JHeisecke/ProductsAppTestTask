//
//  ProductsAppTestTaskTests.swift
//  ProductsAppTestTaskTests
//
//  Created by Javier Heisecke on 2023-01-23.
//

import XCTest
@testable import ProductsAppTestTask

final class LoginViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel!
    
    override func setUpWithError() throws {
        viewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLogin() throws {
        viewModel.login()
        XCTAssertTrue(viewModel.successLogin.value ?? false)
    }

}
