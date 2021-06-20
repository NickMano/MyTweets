//
//  LoginResponse.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

struct LoginResponse: Codable {
    let user: User
    let token: String
}
