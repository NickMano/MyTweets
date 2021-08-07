//
//  NewPostRepositoryMock.swift
//  MyTweetsTests
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import Foundation
@testable import MyTweets

final class PostRepositoryErrorMock: PostRepositoryType {
    func savePost(_ body: PostRequest, onError: @escaping (String) -> Void, onSuccess: @escaping (Post) -> Void) {
        onError("error")
    }
    
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void) {
        onError("error")
    }
    
    func deletePost(_ id: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onError("error")
    }
}

final class PostRepositorySuccesfulMock: PostRepositoryType {
    func savePost(_ body: PostRequest, onError: @escaping (String) -> Void, onSuccess: @escaping (Post) -> Void) {
        let user = User(email: "email", names: "names", nickname: "nickname")
        let post = Post(id: "id", author: user, imageUrl: "imageUrl",
                        hasImage: false, text: "text", videoUrl: "videoUrl",
                        hasVideo: false, createdAt: "createdAt")
        
        onSuccess(post)
    }
    
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void) {
        onSuccess([])
    }
    
    func deletePost(_ id: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onSuccess()
    }
}
