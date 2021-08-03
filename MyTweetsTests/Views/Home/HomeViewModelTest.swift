//
//  HomeViewModelTest.swift
//  MyTweetsTests
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import XCTest
@testable import MyTweets

class HomeViewModelTest: XCTestCase {
    func testGetPostsWithError() {
        let sut = HomeViewModel(repository: PostRepositoryErrorMock())
        var onError = false
        var onSuccess = false
        
        sut.getPosts { _ in
            onError = true
        } onSuccess: { _ in
            onSuccess = true
        }
       
        XCTAssertFalse(onSuccess)
        XCTAssertTrue(onError)
    }
    
    func testGetPostsSuccesful() {
        let sut = HomeViewModel(repository: PostRepositorySuccesfulMock())
        var onError = false
        var onSuccess = false
        
        sut.getPosts { _ in
            onError = true
        } onSuccess: { _ in
            onSuccess = true
        }
        
        XCTAssertTrue(onSuccess)
        XCTAssertFalse(onError)
    }
    
    func testDeletePostsWithError() {
        let sut = HomeViewModel(repository: PostRepositoryErrorMock())
        var onError = false
        var onDeleted = false
        
        sut.deletePost("id", withIndex: IndexPath()) { _ in
            onError = true
        } onDeleted: { _ in
            onDeleted = true
        }

        XCTAssertFalse(onDeleted)
        XCTAssertTrue(onError)
    }
    
    func testDeletePostsSuccesful() {
        let sut = HomeViewModel(repository: PostRepositorySuccesfulMock())
        var onError = false
        var onDeleted = false
        
        sut.deletePost("id", withIndex: IndexPath()) { _ in
            onError = true
        } onDeleted: { _ in
            onDeleted = true
        }

        XCTAssertTrue(onDeleted)
        XCTAssertFalse(onError)
    }
}
