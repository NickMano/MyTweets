//
//  UITableViewCellTest.swift
//  MyTweetsTests
//
//  Created by Nicolas Manograsso on 02/08/2021.
//

import XCTest
@testable import MyTweets

class UITableViewCellTest: XCTestCase {
    func testIdentifier() {
        let identifier = TweetCell.identifier
        XCTAssertEqual(identifier, "TweetCell")
    }
}
