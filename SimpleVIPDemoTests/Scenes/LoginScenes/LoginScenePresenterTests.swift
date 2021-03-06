//
//  LoginScenePresenterTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
@testable import SimpleVIPDemo

final class LoginScenePresenterTests: XCTestCase {
    private var sut: LoginScenePresenter!
    private var vc: LoginScenePresenterOutputMock!
    
    override func setUp() {
        super.setUp()
        
        vc = LoginScenePresenterOutputMock()
        sut = LoginScenePresenter()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        
        super.tearDown()
    }
    
    func test_givenPresenter_whenShowLogingSuccessCalled_thenVCsProperMethodInvoked() {
        sut.showLogingSuccess(user: CleanLoginUser(firstName: "aaa", lastName: "bbb"))
        
        XCTAssertTrue(vc.showLogingSuccessCalled.0)
    }
    
    func test_givenPresenter_whenShowLogingFailureCalled_thenVCsProperMethodInvoked() {
        sut.showLogingFailure(message: "failed...")
        
        XCTAssertTrue(vc.showLogingFailureCalled.0)
    }
    
    func test_givenPresenter_whenShowLogingSuccessCalled_thenVCsProperArgumentPassed() {
        sut.showLogingSuccess(user: CleanLoginUser(firstName: "aaa", lastName: "bbb"))
        
        XCTAssertEqual(vc.showLogingSuccessCalled.1, "aaa bbb")
    }
}

private final class LoginScenePresenterOutputMock: LoginScenePresenterOutput {
   
    var showLogingSuccessCalled: (Bool, String)!
    func showLogInSuccess(fullUserName: String) {
        showLogingSuccessCalled = (true, fullUserName)
    }
    var showLogingFailureCalled: (Bool, String)!
    func showLogInFailure(message: String) {
        showLogingFailureCalled = (true, message)
    }
}
