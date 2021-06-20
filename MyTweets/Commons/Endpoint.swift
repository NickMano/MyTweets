//
//  Endpoints.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

struct Endpoint {
    static let domain = "https://platzi-tweets-backend.herokuapp.com/api/v1"
    static let login = Endpoint.domain + "/auth"
    static let register = Endpoint.domain + "/register"
    static let posts = Endpoint.domain + "/posts"
    static let deletePost = Endpoint.domain + "/posts/"
}
