//
//  LoginViewModelTest.swift
//  MyTweetsTests
//
//  Created by nicolas.e.manograsso on 07/08/2021.
//

import XCTest
@testable import MyTweets

class LoginViewModelTest: XCTestCase {
    var sut: LoginViewModel!
    
    override func setUpWithError() throws {
        sut = LoginViewModel(repository: UserRepositorySuccesfulMock())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testValidForm() {
        let value = sut.isValidForm(password: "pass", email: "email")
        
        XCTAssertTrue(value.isValid)
        XCTAssertNil(value.error)
    }
    
    func testEmptyForm() {
        let value = sut.isValidForm(password: "", email: "")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .allFields)
    }
    
    func testEmptyPassword() {
        let value = sut.isValidForm(password: "", email: "email")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .someField)
    }
    
    func testEmptyEmail() {
        let value = sut.isValidForm(password: "pass", email: "")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .someField)
    }
    
    func testErrorForm() {
        let value = sut.isValidForm(password: "pass", email: nil)
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .generic)
    }
    
    func testGetPostsWithError() {
        sut = LoginViewModel(repository: UserRepositoryErrorMock())
        let request = LoginRequest(email: "email", password: "pass")
        
        var onError = false
        var onSuccess = false
        
        sut.login(request) {_ in
            onError = true
        } onSuccess: {
            onSuccess = true
        }
       
        XCTAssertFalse(onSuccess)
        XCTAssertTrue(onError)
    }
    
    func testGetPostsSuccesful() {
        let request = LoginRequest(email: "email", password: "pass")
        
        var onError = false
        var onSuccess = false
        
        sut.login(request) { _ in
            onError = true
        } onSuccess: {
            onSuccess = true
        }
        
        XCTAssertTrue(onSuccess)
        XCTAssertFalse(onError)
    }
}
