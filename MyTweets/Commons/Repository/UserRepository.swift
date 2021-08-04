//
//  UserRepository.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 03/08/2021.
//

import Foundation
import Alamofire

protocol UserRepositoryType {
    func login(_ data: LoginRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void)
    func register(_ data: RegisterRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void)
}

final class UserRepository: UserRepositoryType {
    func login(_ data: LoginRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        AF.request(Endpoint.login, method: .post, parameters: data, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse ):
                    UserDefaults.standard.setValue(userResponse.user.email, forKey: "email")
                    TokenManager.shared.setToken(userResponse.token)
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
    }
    
    func register(_ data: RegisterRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        AF.request(Endpoint.register, method: .post, parameters: data, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    UserDefaults.standard.setValue(userResponse.user.email, forKey: "email")
                    TokenManager.shared.setToken(userResponse.token)
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
    }
}
