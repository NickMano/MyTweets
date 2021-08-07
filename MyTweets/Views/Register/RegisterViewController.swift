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
    
    // MARK: - Actions
    @objc private func performSignUp() {
        let username = registerView.getUserNameValue()
        let email = registerView.getEmailValue()
        let password = registerView.getPasswordValue()
        let form = viewModel.isValidForm(userName: username,
                                            password: password,
                                            email: email)
        
        if !form.isValid {
            form.error?.showError()
            return
        }
        
        let request = RegisterRequest(email: email!, password: password!, names: username!)
        
        SVProgressHUD.show()
        
        viewModel.register(request) { erorr in
            SVProgressHUD.dismiss()
            NotificationBanner(subtitle: erorr, style: .danger).show()
        } onSuccess: { [weak self] in
            SVProgressHUD.dismiss()
            self?.coordinator?.home()
        }
    }
}
