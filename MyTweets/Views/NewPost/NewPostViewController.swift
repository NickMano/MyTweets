//
//  NewPostViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import UIKit

final class NewPostViewController: UIViewController {
    // MARK: - Private properties
    private let newPostView: NewPostViewProtocol
    
    // MARK: - Public properties
    weak var coordinator: HomeCoordinator?
    
    // MARK: - Initializers
    init(view: NewPostViewProtocol = NewPostView()) {
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
    
    // MARK: - Private methods
    private func configureButtons() {
        newPostView.addButtonAction(#selector(cancelAction), for: .cancel, from: self)
        newPostView.addButtonAction(#selector(postAction), for: .post, from: self)
    }
}

@objc private extension NewPostViewController {
    // MARK: - Actions
    private func cancelAction() {
        coordinator?.cancelPost()
    }
    
    private func postAction() {
        // TODO: post text to server4
    }
}
