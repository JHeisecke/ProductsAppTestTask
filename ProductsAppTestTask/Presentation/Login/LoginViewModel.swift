//
//  LoginViewModel.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import Foundation
import Bond
import ReactiveKit

protocol LoginViewModelProtocol {
    func login()
    var successLogin: Observable<Bool?> { get }
    var username: Observable<String?> { get }
    var password: Observable<String?> { get }
    var isDataValid: Observable<Bool> { get }
}

struct LoginViewModel: LoginViewModelProtocol {
    
    var successLogin: Observable<Bool?> = Observable(nil)
    var username: Observable<String?> = Observable(nil)
    var password: Observable<String?> = Observable(nil)
    var isDataValid: Observable<Bool> = Observable(false)
    var bag: DisposeBag = DisposeBag()
    
    init() {
        validateData()
    }
    
    //ValidateData
    func validateData() {
        combineLatest(username, password){ username, password in
            return username?.count ?? 0 > 0 && password?.count ?? 0 > 0
        }.bind(to: isDataValid).dispose(in: bag)
    }
    
    func login() {
        successLogin.value = true
    }
}
