//
//  UserRepositoryMock.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 07/08/2021.
//

import Foundation
@testable import MyTweets

final class UserRepositoryErrorMock: UserRepositoryType {
    func login(_ data: LoginRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onError("error")
    }
    
    func register(_ data: RegisterRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onError("error")
    }
}

final class UserRepositorySuccesfulMock: UserRepositoryType {
    func login(_ data: LoginRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onSuccess()
    }
    
    func register(_ data: RegisterRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onSuccess()
    }
}
