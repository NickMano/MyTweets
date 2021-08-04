//
//  TokenManager.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 03/08/2021.
//

import Foundation

final class TokenManager {
    private var token: String = ""
    
    static var shared: TokenManager = {
        let instance = TokenManager()
        return instance
    }()
    
    private init() {}
    
    func setToken(_ token: String) {
        self.token = token
    }
    
    func getToken() -> String {
        return token
    }
}
