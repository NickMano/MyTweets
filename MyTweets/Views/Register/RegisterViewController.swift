//
//  RegisterViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import NotificationBannerSwift
import SVProgressHUD
import Simple_Networking
import UIKit

final class RegisterViewController: UIViewController {
    // MARK: - Private properties
    private let registerView: RegisterViewProtocol
    
    // MARK: - Public properties
    weak var coordinator: MainCoordinator?
    
    // MARK: - Initializer
    init(view: RegisterViewProtocol = RegisterView()) {
        registerView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        setupActions()
    }
    
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    // MARK: - Private methods
    private func setupActions() {
        registerView.setSignUpButtonAction(#selector(performSignUp), viewController: self)
    }
    
    private func isFormValid() -> Bool {
        guard let userName = registerView.getUserNameValue(),
              let pass = registerView.getPasswordValue(),
              let email = registerView.getEmailValue() else {
            FormNotification.generic.showError()
            return false
        }
        
        if userName.isEmpty && pass.isEmpty && email.isEmpty {
            FormNotification.allFields.showError()
            return false
        }
        
        if userName.isEmpty || pass.isEmpty || email.isEmpty {
            FormNotification.someField.showError()
            return false
        }
        
        return true
    }
    
    // MARK: - Actions
    @objc private func performSignUp() {
        if !isFormValid() {
            return
        }
        
        guard let userName = registerView.getUserNameValue(),
              let pass = registerView.getPasswordValue(),
              let email = registerView.getEmailValue() else {
            return
        }
        
        let request = RegisterRequest(email: email, password: pass, names: userName)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoint.register,
                model: request) { [weak self] (response: SNResultWithEntity<UserResponse, ErrorResponse>) in
            SVProgressHUD.dismiss()
            
            switch response {
            case .errorResult(let error):
                NotificationBanner(subtitle: error.error, style: .danger).show()
            case .error:
                FormNotification.generic.showError()
            case .success(let user):
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: user.token)
                self?.coordinator?.home()
            }
        }
    }
}
