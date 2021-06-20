//
//  MainCoordinator.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 08/06/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = WelcomeViewController()
        vc.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    func login() {
        let vc = LoginViewController()
        vc.title = "Login"
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    func register() {
        let vc = RegisterViewController()
        vc.title = "Sign Up"
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator {
    func setWelcomeNavSyle() {
        navigationController.isNavigationBarHidden = true
    }
}
