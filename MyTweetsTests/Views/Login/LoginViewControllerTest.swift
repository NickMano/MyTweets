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
    func testView() {
        let viewController = LoginViewController()
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}
