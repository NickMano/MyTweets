//
//  PostDataSource.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import UIKit

final class PostDataSource: NSObject, UITableViewDataSource {
    private let userEmail = UserDefaults.standard.string(forKey: "email") ?? ""
    var posts: [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier, for: indexPath)
        
        guard let postCell = cell as? TweetCell,
              posts.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
        
        postCell.configureWith(posts[indexPath.row])
        return postCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        posts[indexPath.row].author.email == userEmail
    }
}
