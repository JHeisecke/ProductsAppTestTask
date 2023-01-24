//
//  ViewController.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import UIKit
import Bond

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservables()
    }

}

private extension LoginViewController {
    func setupUI() {
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 10
    }
    
    func setupObservables() {
        viewModel?.username.bidirectionalBind(to: usernameTextField.reactive.text)
        viewModel?.password.bidirectionalBind(to: passwordTextField.reactive.text)
        viewModel?.isDataValid.bind(to: loginButton.reactive.isEnabled)
        
        viewModel?.successLogin.observeNext(with: { [weak self] succesLogin in
            guard let succesLogin, succesLogin, let self else { return }
            self.setRootViewController("Home")
        }).dispose(in: bag)
        
        loginButton.reactive.tap.observeNext(with: { [weak self] in
            guard let self else { return }
            self.viewModel?.login()
        })
        .dispose(in: bag)
    }
}
