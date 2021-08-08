//
//  PostRepositoryMock.swift
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
    private let user = User(email: "email", names: "names", nickname: "nickname")
    private let post: Post
    
    var posts: [Post] = []
    
    init() {
        post = Post(id: "id", author: user, imageUrl: "imageUrl",
                    hasImage: true, text: "text", videoUrl: "videoUrl",
                    hasVideo: false, createdAt: "createdAt")
    }
    
    func setNumberOfPosts(_ number: Int) {
        if number <= 0 {
            return
        }
        
        posts = []
        for _ in 0...number {
            posts.append(post)
        }
    }
    
    func savePost(_ body: PostRequest, onError: @escaping (String) -> Void, onSuccess: @escaping (Post) -> Void) {
        onSuccess(post)
    }
    
    func getPosts(onError: @escaping (String) -> Void, onSuccess: @escaping ([Post]) -> Void) {
        onSuccess(posts)
    }
    
    func deletePost(_ id: String, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        onSuccess()
    }
}
