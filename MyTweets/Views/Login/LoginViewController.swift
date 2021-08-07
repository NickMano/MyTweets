//
//  LoginViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 14/06/2021.
//

import NotificationBannerSwift
import Alamofire
import SVProgressHUD
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Private properties
    private let loginView: LoginViewProtocol
    private let viewModel: LoginViewModelType
    
    // MARK: - Public properties
    weak var coordinator: MainCoordinator?
    
    // MARK: - Initializer
    init(view: LoginViewProtocol = LoginView(),
         viewModel: LoginViewModelType = LoginViewModel()) {
        loginView = view
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
        view = loginView
    }
    
    // MARK: - Private methods
    private func setupActions() {
        loginView.setLoginButtonAction(#selector(performLogin), viewController: self)
    }
    
    // MARK: - Actions
    @objc private func performLogin() {
        let email = loginView.getEmailValue()
        let password = loginView.getPasswordValue()
        let form = viewModel.isValidForm(password: password, email: email)
        
        if !form.isValid {
            form.error?.showError()
            return
        }
        
        // A valid user is email: test@test.com password: qwerty
        let request = LoginRequest(email: email!, password: password!)
        
        SVProgressHUD.show()
        
        viewModel.login(request) { error in
            SVProgressHUD.dismiss()
            NotificationBanner(subtitle: error, style: .danger).show()
        } onSuccess: { [weak self] in
            SVProgressHUD.dismiss()
            self?.coordinator?.home()
        }
    }
}

enum FormNotification {
    case generic
    case someField
    case allFields
    
    func showError() {
        switch self {
        case .generic:
            NotificationBanner(title: "Error",
                               subtitle: "An error was occurred",
                               style: .danger).show()
        case .someField:
            NotificationBanner(title: "Error",
                               subtitle: "One or more fields are not valid",
                               style: .warning).show()
        case .allFields:
            NotificationBanner(title: "Error",
                               subtitle: "The fields must be valid",
                               style: .warning).show()
        }
    }
}
