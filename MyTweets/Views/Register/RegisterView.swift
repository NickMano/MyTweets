//
//  RegisterView.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit

protocol RegisterViewProtocol: UIView {
    func setSignUpButtonAction(_ action: Selector, viewController vc: UIViewController)
    
    func getEmailValue() -> String?
    func getUserNameValue() -> String?
    func getPasswordValue() -> String?
}

final class RegisterView: NibView {
    @IBOutlet weak var emailTextField: UIThemeTextField!
    @IBOutlet weak var userNameTextField: UIThemeTextField!
    @IBOutlet weak var passwordTextField: UIThemeTextField!
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.setTitleColor(.label, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .primaryColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegisterView: RegisterViewProtocol {
    func setSignUpButtonAction(_ action: Selector, viewController vc: UIViewController) {
        signUpButton.addTarget(vc, action: action, for: .touchUpInside)
    }
    
    func getEmailValue() -> String? {
        emailTextField.text
    }
    
    func getUserNameValue() -> String? {
        userNameTextField.text
    }
    
    func getPasswordValue() -> String? {
        passwordTextField.text
    }
}
