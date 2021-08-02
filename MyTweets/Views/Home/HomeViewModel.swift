//
//  HomeViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import Simple_Networking

protocol HomeViewModelProtocol {
    func getPosts(onError: @escaping (String) -> Void, onSuccesful: @escaping ([Post]) -> Void)
    func deletePost(_ id: String, withIndex: IndexPath,
                    onError: @escaping (String) -> Void,
                    onDeleted: @escaping (IndexPath) -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    private let repository: PostRepositoryType
    
    init(repository: PostRepositoryType = PostRepository()) {
        self.repository = repository
    }
    
    func getPosts(onError: @escaping (String) -> Void, onSuccesful: @escaping ([Post]) -> Void) {
        repository.getPosts { errorMessage in
            onError(errorMessage)
        } succesfulAction: { posts in
            onSuccesful(posts)
        }
    }
    
    func deletePost(_ id: String, withIndex index: IndexPath,
                    onError: @escaping (String) -> Void,
                    onDeleted: @escaping (IndexPath) -> Void) {
        repository.deletePost(id) { errorMessage in
            onError(errorMessage)
        } succesfulAction: {
            onDeleted(index)
        }
    }
}
