//
//  LoginView.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit
import WolmoCore

protocol LoginViewProtocol: UIView {
    func setupView()
    func setLoginButtonAction(_ action: Selector, viewController vc: UIViewController)
    
    func getEmailValue() -> String?
    func getPasswordValue() -> String?
}

final class LoginView: NibView {
    @IBOutlet weak var emailTextField: UIThemeTextField!
    @IBOutlet weak var passwordTextField: UIThemeTextField!
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitleColor(.label, for: .normal)
            loginButton.layer.borderColor = UIColor.label.cgColor
            loginButton.layer.borderWidth = 1
            loginButton.addShadow(color: UIColor.label.cgColor)
        }
    }
}

extension LoginView: LoginViewProtocol {
    func setupView() {
        self.backgroundColor = .primaryColor
    }
    
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
