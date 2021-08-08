//
//  NewPostViewControllerTest.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 07/08/2021.
//

import XCTest
import SnapshotTesting
@testable import MyTweets

class NewPostViewControllerTest: XCTestCase {
    func testInitWithCoder() {
        expectFatalError(expectedMessage: "init(coder:) has not been implemented") {
            _ = NewPostViewController(coder: NSCoder())
        }
    }
    
    func testView() {
        let viewController = NewPostViewController()
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}
