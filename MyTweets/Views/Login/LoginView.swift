//
//  LoginView.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit

protocol LoginViewProtocol: UIView {
    func setLoginButtonAction(_ action: Selector, viewController vc: UIViewController)
    
    func getEmailValue() -> String?
    func getPasswordValue() -> String?
}

final class LoginView: NibView {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
}

extension LoginView: LoginViewProtocol {
    func setLoginButtonAction(_ action: Selector, viewController vc: UIViewController) {
        loginButton.addTarget(vc, action: action, for: .touchUpInside)
    }
    
    func getEmailValue() -> String? {
        emailTextField.text
    }
    
    func getPasswordValue() -> String? {
        passwordTextField.text
    }
}
