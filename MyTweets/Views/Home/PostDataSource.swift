//
//  PostDataSource.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import UIKit

final class PostDataSource: NSObject, UITableViewDataSource {
    var posts: [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier, for: indexPath)
        
        guard let tweetCell = cell as? TweetCell,
              posts.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
        
        tweetCell.configureWith(posts[indexPath.row])
        
        return tweetCell
    }
    
    
}
