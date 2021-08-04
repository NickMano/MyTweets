//
//  RegisterViewModelTest.swift
//  MyTweetsTests
//
//  Created by Nicolas Manograsso on 04/08/2021.
//

import XCTest
@testable import MyTweets

final class RegisterViewModelTest: XCTestCase {
    func testValidForm() {
        let sut = RegisterViewModel()
        
        let value = sut.isValidForm(userName: "user", password: "pass", email: "email")
        
        XCTAssertTrue(value.isValid)
        XCTAssertNil(value.error)
    }
    
    func testEmptyForm() {
        let sut = RegisterViewModel()
        
        let value = sut.isValidForm(userName: "", password: "", email: "")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .allFields)
    }
    
    func testEmptyUserName() {
        let sut = RegisterViewModel()
        
        let value = sut.isValidForm(userName: "", password: "pass", email: "email")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .someField)
    }
    
    func testEmptyPassword() {
        let sut = RegisterViewModel()
        
        let value = sut.isValidForm(userName: "user", password: "", email: "email")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .someField)
    }
    
    func testEmptyEmail() {
        let sut = RegisterViewModel()
        
        let value = sut.isValidForm(userName: "user", password: "pass", email: "")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .someField)
    }
    
    func testErrorForm() {
        let sut = RegisterViewModel()
        
        let value = sut.isValidForm(userName: nil, password: "pass", email: "")
        
        XCTAssertFalse(value.isValid)
        XCTAssertEqual(value.error, .generic)
    }
}
