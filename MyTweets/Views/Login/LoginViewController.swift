//
//  LoginViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 14/06/2021.
//

import NotificationBannerSwift
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Private properties
    private let loginView: LoginViewProtocol
    
    // MARK: - Public properties
    weak var coordinatior: MainCoordinator?
    
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
            FormNotification.generic.showError()
            return
        }
        
        if userName.isEmpty && pass.isEmpty {
            FormNotification.allFields.showError()
            return
        }
        
        if userName.isEmpty || pass.isEmpty {
            FormNotification.someField.showError()
            return
        }
        
        // TODO: Perform login
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
                               subtitle: "An error was occured",
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
