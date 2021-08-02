//
//  PostRepository.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import Foundation
import Simple_Networking

protocol PostRepositoryType {
    func savePost(_ body: PostRequest,
                  errorAction: @escaping (String) -> Void,
                  succesfulAction: @escaping (Post) -> Void)
    
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void)
    
    func deletePost(_ id: String, errorAction: @escaping (String) -> Void, succesfulAction: @escaping () -> Void)
}

final class PostRepository: PostRepositoryType {
    func savePost(_ body: PostRequest,
                  errorAction: @escaping (String) -> Void,
                  succesfulAction: @escaping (Post) -> Void) {
        
        SN.post(endpoint: Endpoint.posts,
                model: body) { (response: SNResultWithEntity<Post, ErrorResponse>) in
            switch response {
            case .success(let post):
                succesfulAction(post)
            case .error(let error):
                errorAction(error.localizedDescription)
            case .errorResult(let error):
                errorAction(error.error)
            }
        }
    }
    
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void) {
        SN.get(endpoint: Endpoint.posts) { (response: SNResultWithEntity<[Post], ErrorResponse>) in
            switch response {
            case .success(let posts):
                succesfulAction(posts)
            case .error(let error):
                errorAction(error.localizedDescription)
            case .errorResult(let error):
                errorAction(error.error)
            }
        }
    }
    
    func deletePost(_ id: String,
                    errorAction: @escaping (String) -> Void,
                    succesfulAction: @escaping () -> Void) {
        let endpoind = Endpoint.deletePost + id
        SN.delete(endpoint: endpoind) { (response: SNResultWithEntity<GeneralResponse, ErrorResponse>) in
            switch response {
            case .success:
                succesfulAction()
            case .error(let error):
                errorAction(error.localizedDescription)
            case .errorResult(let error):
                errorAction(error.error)
            }
        }
    }
}
