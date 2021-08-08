//
//  TokenManagerTest.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 08/08/2021.
//

import XCTest
@testable import MyTweets

class TokenManagerTest: XCTestCase {
    func tesInit() {
        let sut = TokenManager.shared
        
        XCTAssertTrue(sut.getToken().isEmpty)
    }
    
    func testSetAndGet() {
        let sut = TokenManager.shared
        let token = "token"
        
        sut.setToken(token)
        
        XCTAssertEqual(sut.getToken(), token)
    }
}
