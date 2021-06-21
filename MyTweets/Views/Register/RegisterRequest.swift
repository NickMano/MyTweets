//
//  RegisterRequest.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 20/06/2021.
//

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let names: String
}
