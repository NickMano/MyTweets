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
    private let viewModel: RegisterViewModelType
    
    // MARK: - Public properties
    weak var coordinator: MainCoordinator?
    
    // MARK: - Initializer
    init(view: RegisterViewProtocol = RegisterView(),
         viewModel: RegisterViewModelType = RegisterViewModel()) {
        registerView = view
        self.viewModel = viewModel
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
        let value = viewModel.isValidForm(userName: registerView.getUserNameValue(),
                                            password: registerView.getPasswordValue(),
                                            email: registerView.getEmailValue())
        
        if !value.isValid {
            value.error?.showError()
            return
        }
        
        let request = RegisterRequest(email: registerView.getUserNameValue()!,
                                      password: registerView.getPasswordValue()!,
                                      names: registerView.getEmailValue()!)
        
        SVProgressHUD.show()
        
        viewModel.register(request) { erorr in
            SVProgressHUD.dismiss()
            NotificationBanner(subtitle: erorr, style: .danger).show()
        } onSuccess: {
            SVProgressHUD.dismiss()
            self.coordinator?.home()
        }
    }
}
