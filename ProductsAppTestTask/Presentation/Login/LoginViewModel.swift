//
//  LoginViewModel.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation

protocol LoginViewModelProtocol {
    func login()
}

struct LoginViewModel: LoginViewModelProtocol {
    
    func login() {
        print("user logged!")
    }
}
