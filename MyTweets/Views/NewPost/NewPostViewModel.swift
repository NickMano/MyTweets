//
//  NewPostViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import Foundation

protocol NewPostViewModelProtocol {
    func savePost(_ text: String, onError: @escaping (String) -> Void, onSaved: @escaping (Post) -> Void)
}

final class NewPostViewModel: NewPostViewModelProtocol {
    private let repository: PostRepositoryType
    
    init(repository: PostRepositoryType = PostRepository()) {
        self.repository = repository
    }
    
    func savePost(_ text: String, onError: @escaping (String) -> Void, onSaved: @escaping (Post) -> Void) {
        let request = PostRequest(text: text, imageUrl: nil, videoUrl: nil)
        
        repository.savePost(request) { errorMessage in
            onError(errorMessage)
        } onSuccess: { post in
            onSaved(post)
        }
    }
}
