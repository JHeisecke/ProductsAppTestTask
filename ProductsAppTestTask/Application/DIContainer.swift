//
//  DIContainer.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation
import SwinjectStoryboard
import Swinject

struct DIContainer {
    static func setup(_ container: Container) {
        container.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(LoginViewModelProtocol.self)
        }
        container.register(LoginViewModelProtocol.self) { service in
            LoginViewModel()
        }
        container.register(GetAllProductsUseCaseProtocol.self) { service in
            GetAllProductsUseCase(repository: service.resolve(ProductsRepositoryProtocol.self)!)
        }
        container.register(GetProductDetailUseCaseProtocol.self) { service in
            GetProductDetailUseCase(repository: service.resolve(ProductsRepositoryProtocol.self)!)
        }
        container.register(ProductsRepositoryProtocol.self) { service in
            ProductsRepository(api: service.resolve(ApiClient.self)!)
        }
        container.register(ApiClient.self) { _ in
            ApiClient()
        }
    }
}
