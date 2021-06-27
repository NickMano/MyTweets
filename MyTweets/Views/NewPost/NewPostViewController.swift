//
//  NewPostViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import NotificationBannerSwift
import SVProgressHUD
import UIKit

final class NewPostViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel: NewPostViewModelProtocol
    private let newPostView: NewPostViewProtocol
    
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
    }
    
    override func loadView() {
        view = newPostView
    }
}

private extension NewPostViewController {
    // MARK: - Private methods
    func configureButtons() {
        newPostView.addButtonAction(#selector(cancelAction), for: .cancel, from: self)
        newPostView.addButtonAction(#selector(postAction), for: .post, from: self)
    }
    
    func errorPost(_ message: String) {
        SVProgressHUD.dismiss()
        NotificationBanner(subtitle: message, style: .danger).show()
    }
    
    func hasPost(_ post: Post) {
        SVProgressHUD.dismiss()
        coordinator?.finishPost(post)
    }
}

@objc private extension NewPostViewController {
    // MARK: - Actions
    private func cancelAction() {
        coordinator?.finishPost()
    }
    
    private func postAction() {
        SVProgressHUD.show()
        viewModel.savePost(newPostView.getPostText(), errorAction: errorPost(_:), succesfulAction: hasPost(_:))
    }
}
