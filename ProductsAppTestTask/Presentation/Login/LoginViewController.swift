//
//  ViewController.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

}

private extension LoginViewController {
    func setupUI() {
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 10
        loginButton.setBackgroundColor(UIColor(named: "brand-foreground"), for: .normal)
        loginButton.setBackgroundColor(UIColor(named: "brand-foreground")?.withAlphaComponent(0.3), for: .disabled)
    }
    
    func setupBindings() {
        
        subscriptions = [
            viewModel.$enableButton.assign(to: \.isEnabled, on: loginButton)
        ]
        
        viewModel.$logged.sink(receiveValue: { isLogged in
            if isLogged {
                print("logged")
            }
        })
        .store(in: &subscriptions)
        
        usernameTextField.textPublisher.assign(to: &viewModel.$username)
        passwordTextField.textPublisher.assign(to: &viewModel.$password)
        
    }
}
