//
//  LoginViewControllerTest.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 07/08/2021.
//

import XCTest
import SnapshotTesting
@testable import MyTweets

class LoginViewControllerTest: XCTestCase {
    func testInitWithCoder() {
        expectFatalError(expectedMessage: "init(coder:) has not been implemented") {
            _ = LoginViewController(coder: NSCoder())
        }
    }
    
    func testView() {
        let viewController = LoginViewController()
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}
