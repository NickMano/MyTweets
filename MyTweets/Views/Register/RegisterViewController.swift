//
//  RegisterViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit

final class RegisterViewController: UIViewController {
    // MARK: - Private properties
    private let registerView: RegisterViewProtocol
    
    // MARK: - Public properties
    weak var coordinatior: MainCoordinator?
    
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
    
    // MARK: - Actions
    @objc private func performSignUp() {
        guard let userName = registerView.getUserNameValue(),
              let pass = registerView.getPasswordValue(),
              let email = registerView.getEmailValue() else {
            FormNotification.generic.showError()
            return
        }
        
        if userName.isEmpty && pass.isEmpty && email.isEmpty {
            FormNotification.allFields.showError()
            return
        }
        
        if userName.isEmpty || pass.isEmpty || email.isEmpty {
            FormNotification.someField.showError()
            return
        }
        
        // TODO: Perform Sign Up
    }
}
