//
//  HomeView.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import UIKit

protocol HomeViewProtocol: UIView {
    var postTable: UITableView { get }
    
    func addPostButtonAction(_ action: Selector, from vc: UIViewController)
}

final class HomeView: NibView {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var postsTable: UITableView!
    @IBOutlet weak var newPostButton: UIButton! {
        didSet {
            newPostButton.layer.cornerRadius = 24
        }
    }
}

extension HomeView: HomeViewProtocol {
    var postTable: UITableView { postsTable }
    
    func addPostButtonAction(_ action: Selector, from vc: UIViewController) {
        newPostButton.addTarget(vc, action: action, for: .touchUpInside)
    }
}
