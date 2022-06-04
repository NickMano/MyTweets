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
        vc.title = "Discover"
        
        let map = UIBarButtonItem(image: UIImage(systemName: "map"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(self.map))
        map.tintColor = .label
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [vc]
        
        navigationController.navigationBar.topItem?.rightBarButtonItem = map
        navigationController.navigationBar.backgroundColor = .primaryColor
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
    
    func openCamera(from vc: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraFlashMode = .off
        imagePicker.cameraCaptureMode = .photo
        imagePicker.allowsEditing = true
        imagePicker.delegate = vc
        
        navigationController.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func map() {
        let topViewController = navigationController.topViewController as? HomeViewController
        var vc : MapViewController
        
        if let homeViewController = topViewController {
            let posts = homeViewController.posts
            vc = MapViewController(posts: posts)
        } else {
            vc = MapViewController()
        }
        
        vc.coordinator = self
        vc.title = "Map"
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(vc, animated: true)
    }
}
