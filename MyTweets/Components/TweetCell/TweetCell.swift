//
//  TweetCell.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import UIKit
import Kingfisher

final class TweetCell: UITableViewCell {
    // MARK: - IBOulets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView! {
        didSet {
            tweetImageView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var videoButton: UIButton!
    
    func configureWith(_ post: Post) {
        nameLabel.text = post.author.names
        userNameLabel.text = "\(post.author.nickname) · \(post.createdAt)"
        messageLabel.text = post.text
        
        if post.hasImage {
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl))
        } else {
            tweetImageView.isHidden = true
        }
        
        if post.hasVideo {
            
        } else {
            videoButton.isHidden = true
        }
    }
}
