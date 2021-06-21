//
//  HomeViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

import UIKit
import SVProgressHUD

final class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    weak var coordinator: HomeCoordinator?
    var dataSource = PostDataSource()
    
    // MARK: - Private properties
    private let viewModel: HomeViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        getPosts()
    }
    
    // MARK: - Private methods
    private func configureTable() {
        tableView.dataSource = dataSource
        
        let nib = UINib(nibName: TweetCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TweetCell.identifier)
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
        tableView.reloadData()
    }
}
