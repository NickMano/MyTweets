//
//  NewPostViewModelTest.swift
//  MyTweetsTests
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import XCTest
@testable import MyTweets

class NewPostViewModelTest: XCTestCase {
    func testSavePostWithError() {
        let sut = NewPostViewModel(repository: PostRepositoryErrorMock())
        var onError = false
        var onSaved = false
        
        sut.savePost("") { _ in
            onError = true
        } onSaved: { _ in
            onSaved = true
        }
       
        XCTAssertFalse(onSaved)
        XCTAssertTrue(onError)
    }
    
    func testSavePostSuccesfull() {
        let sut = NewPostViewModel(repository: PostRepositorySuccesfulMock())
        var onError = false
        var onSaved = false
        
        sut.savePost("") { _ in
            onError = true
        } onSaved: { _ in
            onSaved = true
        }
       
        XCTAssertTrue(onSaved)
        XCTAssertFalse(onError)
    }
}