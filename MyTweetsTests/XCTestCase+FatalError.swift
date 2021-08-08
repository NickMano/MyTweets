//
//  XCTestCase+FatalError.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 08/08/2021.
//

import XCTest
@testable import MyTweets

extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String?
        
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        DispatchQueue.init(label: "test").async(execute: testcase)
        
        waitForExpectations(timeout: 2) { _ in
            FatalErrorUtil.restoreFatalError()
        }
        
        XCTAssertEqual(assertionMessage, expectedMessage)
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
