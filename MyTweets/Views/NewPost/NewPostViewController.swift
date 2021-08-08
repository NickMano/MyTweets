//
//  NewPostViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import NotificationBannerSwift
import SVProgressHUD
import CoreLocation
import UIKit

final class NewPostViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel: NewPostViewModelProtocol
    private let newPostView: NewPostViewProtocol
    private let locationDelegate = NewPostLocationDelegate()
    
    private var locationManager: CLLocationManager?
    
    // MARK: - Public properties
    weak var coordinator: HomeCoordinator?
    
    // MARK: - Initializers
    init(viewModel: NewPostViewModelProtocol = NewPostViewModel(),
         view: NewPostViewProtocol = NewPostView()) {
        self.viewModel = viewModel
        newPostView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        configureButtons()
        requestLocation()
    }
    
    override func loadView() {
        view = newPostView
    }

    // MARK: - Private methods
    private func configureButtons() {
        newPostView.addButtonAction(#selector(cancelAction), for: .cancel, from: self)
        newPostView.addButtonAction(#selector(postAction), for: .post, from: self)
        newPostView.addButtonAction(#selector(openCameraAction), for: .openCamera, from: self)
    }
    
    private func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        locationManager = CLLocationManager()
        locationManager?.delegate = locationDelegate
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager?.requestAlwaysAuthorization()
    }
}

@objc private extension NewPostViewController {
    // MARK: - Actions
    func cancelAction() {
        coordinator?.finishPost()
    }
    
    func postAction() {
        SVProgressHUD.show()
        
        if let image = newPostView.getImage(){
            viewModel.uploadPhotoToFirebase(image) { [weak self] imageUrl in
                self?.savePost(imageUrl: imageUrl)
            }
            
            return
        }
        
        savePost()
    }
    
    func savePost(imageUrl: String? = nil) {
        let postData = PostRequest(text: newPostView.getPostText(), imageUrl: imageUrl, videoUrl: nil)
        
        viewModel.savePost(postData) { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                NotificationBanner(subtitle: error.localizedDescription, style: .danger).show()
            case .success(let post):
                self?.coordinator?.finishPost(post)
            }
        }
    }
    
    func openCameraAction() {
        coordinator?.openCamera(from: self)
    }
}

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard info.keys.contains(.originalImage),
              let image = info[.originalImage] as? UIImage else {
            return
        }
        
        newPostView.setImage(image)
    }
}
