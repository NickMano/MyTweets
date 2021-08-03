//
//  RegisterViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import NotificationBannerSwift
import Alamofire
import SVProgressHUD
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
        guard isFormValid(),
              let userName = registerView.getUserNameValue(),
              let pass = registerView.getPasswordValue(),
              let email = registerView.getEmailValue() else {
            return
        }
        
        let request = RegisterRequest(email: email, password: pass, names: userName)
        
        SVProgressHUD.show()
        
        AF.request(Endpoint.register, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                SVProgressHUD.dismiss()
                
                switch response.result {
                case .success(let userResponse):
//                    SimpleNetworking.setAuthenticationHeader(prefix: "", token: userResponse.token)
                    UserDefaults.standard.setValue(userResponse.user.email, forKey: "email")
                    self.coordinator?.home()
                case .failure(let error):
                    NotificationBanner(subtitle: error.localizedDescription, style: .danger).show()
                }
            }
    }
}
