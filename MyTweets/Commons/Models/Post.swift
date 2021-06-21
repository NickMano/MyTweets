//
//  Post.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

struct Post: Codable {
    let id: String
    let author: User
    let imageUrl: String
    let hasImage: Bool
    let text: String
    let videoUrl: String
    let hasVideo: Bool
    let createdAt: String
}
