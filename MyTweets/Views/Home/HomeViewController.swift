//
//  HomeViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import NotificationBannerSwift
import SVProgressHUD
import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Public properties
    weak var coordinator: HomeCoordinator?
    
    // MARK: - Private properties
    private let viewModel: HomeViewModelProtocol
    private let homeView: HomeViewProtocol
    private var tableDataSource = PostDataSource()
    
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
    
    // MARK: - Public methods
    func updateDataWith(_ post: Post) {
        tableDataSource.posts.insert(post, at: 0)
        homeView.postTable.reloadData()
    }
    
    // MARK: - Private methods
    private func configureTable() {
        homeView.postTable.dataSource = tableDataSource
        homeView.postTable.delegate = self
        
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
        viewModel.getPosts(onError: errorPosts(_:), onSuccesful: setPosts(_:))
    }
    
    func setPosts(_ posts: [Post]) {
        SVProgressHUD.dismiss()
        tableDataSource.posts = posts
        homeView.postTable.reloadData()
    }
    
    func deletePostAt(_ index: IndexPath) {
        SVProgressHUD.show()
        let postId = tableDataSource.posts[index.row].id
        viewModel.deletePost(postId,
                             withIndex: index,
                             onError: errorPosts(_:),
                             onDeleted: deletePostFromTable(_:))
    }
    
    func deletePostFromTable(_ index: IndexPath) {
        SVProgressHUD.dismiss()
        tableDataSource.posts.remove(at: index.row)
        homeView.postTable.deleteRows(at: [index], with: .fade)
    }
    
    func errorPosts(_ message: String) {
        SVProgressHUD.dismiss()
        NotificationBanner(title: "Error",
                           subtitle: message,
                           style: .warning).show()

    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: nil) { [weak self] (_, _, completionHandler) in
            self?.deletePostAt(indexPath)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
