//
//  HomeViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import Simple_Networking

protocol HomeViewModelProtocol {
    var posts: [Post] { get }
    
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping () -> Void)
    func addPost(_ post: Post)
}

final class HomeViewModel: HomeViewModelProtocol {
    private(set) var posts: [Post] = []
    
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping () -> Void) {
        SN.get(endpoint: Endpoint.posts) { (response: SNResultWithEntity<[Post], ErrorResponse>) in
            switch response {
            case .success(let posts):
                self.posts = posts
                succesfulAction()
            case .error(let error):
                errorAction(error.localizedDescription)
            case .errorResult(let error):
                errorAction(error.error)
            }
        }
    }
    
    func addPost(_ post: Post) {
        posts.insert(post, at: 0)
    }
}
