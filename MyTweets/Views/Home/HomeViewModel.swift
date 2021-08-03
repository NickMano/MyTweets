//
//  HomeViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import Foundation

protocol HomeViewModelProtocol {
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void)
    func deletePost(_ id: String, withIndex: IndexPath,
                    onError: @escaping (String) -> Void,
                    onDeleted: @escaping (IndexPath) -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    private let repository: PostRepositoryType
    
    init(repository: PostRepositoryType = PostRepository()) {
        self.repository = repository
    }
    
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void) {
        repository.getPosts { errorMessage in
            onError(errorMessage)
        } onSuccess: { posts in
            onSuccess(posts)
        }
    }
    
    func deletePost(_ id: String, withIndex index: IndexPath,
                    onError: @escaping (String) -> Void,
                    onDeleted: @escaping (IndexPath) -> Void) {
        repository.deletePost(id) { errorMessage in
            onError(errorMessage)
        } onSuccess: {
            onDeleted(index)
        }
    }
}
