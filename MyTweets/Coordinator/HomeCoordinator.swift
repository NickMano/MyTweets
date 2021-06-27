//
//  HomeCoordinator.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.title = "Home"
        
        navigationController.viewControllers = [vc]
    }
    
    func newPost() {
        let vc = NewPostViewController()
        vc.coordinator = self
        vc.modalPresentationStyle = .automatic
        navigationController.present(vc, animated: true)
    }
    
    func finishPost(_ post: Post? = nil) {
        guard let post = post,
              let vc = navigationController.viewControllers.first as? HomeViewController else {
            navigationController.dismiss(animated: true)
            return
        }
        
        vc.updateDataWith(post)
        navigationController.dismiss(animated: true)
    }
}
