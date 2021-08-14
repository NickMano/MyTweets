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
    let text: String
    let videoUrl: String
    let location: PostLocation
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}

struct PostLocation: Codable {
    let latitude: Double
    let longitude: Double
}
