//
//  PostRequest.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

struct PostRequest: Codable {
    let text: String
    let imageUrl: String?
    let videoUrl: String?
    let location: PostRequestLocation?
}

struct PostRequestLocation: Codable {
    let latitude: Double
    let longitude: Double
}
