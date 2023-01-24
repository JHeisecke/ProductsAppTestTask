//
//  LoginViewModel.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation
import Combine
class LoginViewModel {
    
    @Published var logged = false
    @Published var enableButton: Bool = false
    @Published var username: String? = ""
    @Published var password: String? = ""
    
    init() {
        checkFields()
    }
    
    func checkFields() {
        return Publishers.CombineLatest($username, $password)
            .map { username, password in
                let enable = !(username?.isEmpty ?? true) && !(password?.isEmpty ?? true)
                print(enable)
                return enable
            }
            .receive(on: RunLoop.main)
            .assign(to: &$enableButton)
    }
    
    func login() {
        logged = true
    }
}
