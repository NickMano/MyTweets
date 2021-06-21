//
//  HomeViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import Simple_Networking

protocol HomeViewModelProtocol {
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void) {
        SN.get(endpoint: Endpoint.posts) { (response: SNResultWithEntity<[Post], ErrorResponse>) in
            switch response {
            case .success(let tweets):
                succesfulAction(tweets)
            case .error(let error):
                errorAction(error.localizedDescription)
            case .errorResult(let error):
                errorAction(error.error)
            }
        }
    }
}
