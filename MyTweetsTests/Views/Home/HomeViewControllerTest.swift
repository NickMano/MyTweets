//
//  HomeViewControllerTest.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 07/08/2021.
//

import XCTest
import SnapshotTesting
@testable import MyTweets

class HomeViewControllerTest: XCTestCase {
    func testView() {
        let repository = PostRepositorySuccesfulMock()
        repository.setNumberOfPosts(10)
        
        let viewModel = HomeViewModel(repository: repository)
        let viewController = HomeViewController(viewModel: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
    
    func testEmptyView() {
        let repository = PostRepositorySuccesfulMock()
        let viewModel = HomeViewModel(repository: repository)
        let viewController = HomeViewController(viewModel: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
    
    func testErrorView() {
        let repository = PostRepositoryErrorMock()
        let viewModel = HomeViewModel(repository: repository)
        let viewController = HomeViewController(viewModel: viewModel)
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8))
        assertSnapshot(matching: viewController, as: .image(on: .iPhone8Plus))
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}
