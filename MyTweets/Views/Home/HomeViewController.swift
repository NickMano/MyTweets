//
//  HomeViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit
import SVProgressHUD

final class HomeViewController: UIViewController {
    // MARK: - Public properties
    weak var coordinator: HomeCoordinator?
    var dataSource = PostDataSource()
    
    // MARK: - Private properties
    private let viewModel: HomeViewModelProtocol
    private let homeView: HomeViewProtocol
    
    // MARK: - Initializers
    init(viewModel: HomeViewModelProtocol = HomeViewModel(),
         view: HomeViewProtocol = HomeView()) {
        self.viewModel = viewModel
        homeView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureButtons()
        getPosts()
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    // MARK: - Private methods
    private func configureTable() {
        homeView.postTable.dataSource = dataSource
        
        let nib = UINib(nibName: TweetCell.identifier, bundle: nil)
        homeView.postTable.register(nib, forCellReuseIdentifier: TweetCell.identifier)
    }
    
    private func configureButtons() {
        homeView.addPostButtonAction(#selector(newPostAction), from: self)
    }
    
    // MARK: - Actions
    @objc private func newPostAction() {
        coordinator?.newPost()
    }
}

private extension HomeViewController {
    // MARK: - Posts methods
    func getPosts() {
        SVProgressHUD.show()
        viewModel.getPosts(errorAction: errorPosts(_:), succesfulAction: setPosts(_:))
    }
    
    func errorPosts(_ message: String) {
        SVProgressHUD.dismiss()
    }
    
    func setPosts(_ posts: [Post]) {
        SVProgressHUD.dismiss()
        dataSource.posts = posts
        homeView.postTable.reloadData()
    }
}
