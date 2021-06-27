//
//  NewPostViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import Foundation
import Simple_Networking

protocol NewPostViewModelProtocol {
    func savePost(_ text: String, errorAction: @escaping (String) -> Void, succesfulAction: @escaping (Post) -> Void)
}

final class NewPostViewModel: NewPostViewModelProtocol {
    func savePost(_ text: String, errorAction: @escaping (String) -> Void, succesfulAction: @escaping (Post) -> Void) {
        let request = PostRequest(text: text, imageUrl: nil, videoUrl: nil)
        
        SN.post(endpoint: Endpoint.posts,
                model: request) { (response: SNResultWithEntity<Post, ErrorResponse>) in
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
}
