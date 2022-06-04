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
    @IBOutlet weak var contentCellView: UIView! {
        didSet {
            contentCellView.layer.masksToBounds = true
            contentCellView.addShadow()
            contentCellView.backgroundColor = .secondaryColor
            backgroundColor = .homeBackground
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView! {
        didSet {
            tweetImageView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var videoButton: UIButton!
    
    func configureWith(_ post: Post) {
        nameLabel.text = post.author.names
        userNameLabel.text = "\(post.author.nickname) · \(post.createdAt)"
        messageLabel.text = post.text
        
        if post.hasImage {
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl), completionHandler:  { [weak self] response in
                switch response {
                case .success:
                    self?.tweetImageView.contentMode = .scaleAspectFill
                case .failure:
                    self?.setImagePlaceholder()
                }
            })
            
            if tweetImageView.image == nil {
                setImagePlaceholder()
            }
        } else {
            tweetImageView.isHidden = true
        }
        
        if post.hasVideo {
            
        } else {
            videoButton.isHidden = true
        }
    }
    
    private func setImagePlaceholder() {
        tweetImageView.image = UIImage(named: "imagePlaceholder")
        tweetImageView.contentMode = .center
    }
}
