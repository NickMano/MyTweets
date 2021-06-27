//
//  HomeViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 21/06/2021.
//

import Simple_Networking

protocol HomeViewModelProtocol {
    func getPosts(errorAction: @escaping (String) -> Void, succesfulAction: @escaping ([Post]) -> Void)
    func deletePost(_ id: String,
                    index: IndexPath,
                    errorAction: @escaping (String) -> Void,
                    succesfulAction: @escaping (IndexPath) -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
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
    
    func deletePost(_ id: String, index: IndexPath,
                    errorAction: @escaping (String) -> Void,
                    succesfulAction: @escaping (IndexPath) -> Void) {
        let endpoind = Endpoint.deletePost + id
        SN.delete(endpoint: endpoind) { (response: SNResultWithEntity<GeneralResponse, ErrorResponse>) in
            switch response {
            case .success:
                succesfulAction(index)
            case .error(let error):
                errorAction(error.localizedDescription)
            case .errorResult(let error):
                errorAction(error.error)
            }
        }
    }
}
