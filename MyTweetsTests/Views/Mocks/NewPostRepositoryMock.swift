//
//  NewPostRepositoryMock.swift
//  MyTweetsTests
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import Foundation
@testable import MyTweets

final class PostRepositoryErrorMock: PostRepositoryType {
    func savePost(_ body: PostRequest,
                  errorAction: @escaping (String) -> Void,
                  succesfulAction: @escaping (Post) -> Void) {
        errorAction("error")
    }
    
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void) {
        errorAction("error")
    }
    
    func deletePost(_ id: String, errorAction: @escaping (String) -> Void, succesfulAction: @escaping () -> Void) {
        errorAction("error")
    }
}

final class PostRepositorySuccesfulMock: PostRepositoryType {
    func savePost(_ body: PostRequest,
                  errorAction: @escaping (String) -> Void,
                  succesfulAction: @escaping (Post) -> Void) {
        let user = User(email: "email", names: "names", nickname: "nickname")
        let post = Post(id: "id", author: user, imageUrl: "imageUrl",
                        hasImage: false, text: "text", videoUrl: "videoUrl",
                        hasVideo: false, createdAt: "createdAt")
        
        succesfulAction(post)
    }
    
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void) {
        succesfulAction([])
    }
    
    func deletePost(_ id: String, errorAction: @escaping (String) -> Void, succesfulAction: @escaping () -> Void) {
        succesfulAction()
    }
}
