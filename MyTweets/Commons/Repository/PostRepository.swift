//
//  PostRepository.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import Foundation
import Alamofire

protocol PostRepositoryType {
    func savePost(_ body: PostRequest,
                  onError: @escaping (String) -> Void,
                  onSuccess: @escaping (Post) -> Void)
    
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void)
    
    func deletePost(_ id: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void)
}

final class PostRepository: PostRepositoryType {
    func savePost(_ body: PostRequest,
                  onError: @escaping (String) -> Void,
                  onSuccess: @escaping (Post) -> Void) {
        
        let header = HTTPHeaders(arrayLiteral: HTTPHeader.authorization(TokenManager.shared.getToken()))
        AF.request(Endpoint.posts, method: .post, parameters: body,
                   encoder: JSONParameterEncoder.default, headers: header)
            .validate()
            .responseDecodable(of: Post.self) { response in
                switch response.result {
                case .success(let post):
                    onSuccess(post)
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
    }
    
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void) {
        let header = HTTPHeaders(arrayLiteral: HTTPHeader.authorization(TokenManager.shared.getToken()))
        AF.request(Endpoint.posts, method: .get, headers: header)
            .validate()
            .responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let posts):
                    onSuccess(posts)
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
    }
    
    func deletePost(_ id: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        let header = HTTPHeaders(arrayLiteral: HTTPHeader.authorization(TokenManager.shared.getToken()))
        let endpoint = Endpoint.deletePost + id
        AF.request(endpoint, method: .delete, headers: header)
            .validate()
            .responseDecodable(of: GeneralResponse.self) { response in
                switch response.result {
                case .success:
                    onSuccess()
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
    }
}
