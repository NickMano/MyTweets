//
//  LoginViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 14/06/2021.
//

import NotificationBannerSwift
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Public properties
    weak var coordinatior: MainCoordinator?
    
    // MARK: - Private properties
    private let loginView: LoginViewProtocol
    
    // MARK: - Initializer
    init(view: LoginViewProtocol = LoginView()) {
        loginView = view
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
        guard let userName = loginView.getUserNameValue(), let pass = loginView.getPasswordValue() else {
            LoginNotification.generic.showError()
            return
        }
        
        if userName.isEmpty && pass.isEmpty {
            LoginNotification.allFields.showError()
            return
        }
        
        if userName.isEmpty {
            LoginNotification.userName.showError()
            return
        }
        
        if pass.isEmpty {
            LoginNotification.password.showError()
            return
        }
        
        // TODO: Perform login
    }
}

enum LoginNotification {
    case generic
    case password
    case userName
    case allFields
    
    func showError() {
        switch self {
        case .generic:
            NotificationBanner(title: "Error",
                               subtitle: "An error was occured",
                               style: .danger).show()
        case .password:
            NotificationBanner(title: "Error",
                               subtitle: "The password is not valid",
                               style: .warning).show()
        case .userName:
            NotificationBanner(title: "Error",
                               subtitle: "The username is not valid",
                               style: .warning).show()
        case .allFields:
            NotificationBanner(title: "Error",
                               subtitle: "The fields must be valid",
                               style: .warning).show()
        }
    }
}
