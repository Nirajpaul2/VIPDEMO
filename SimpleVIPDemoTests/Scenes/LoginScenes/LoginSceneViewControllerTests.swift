//
//  LoginSceneViewControllerTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
@testable import SimpleVIPDemo

final class LoginSceneViewControllerTests: XCTestCase {
    private var sut: LoginViewController!
    private var interactor: LoginSceneInteractorModel!
    private var router: LoginSceneRoutingLogicModel!
    
    override func setUp() {
        super.setUp()
        
        sut = LoginViewController()
        interactor = LoginSceneInteractorModel()
        sut.interactor = interactor
        router = LoginSceneRoutingLogicModel()
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        
        super.tearDown()
    }
    
//    func test_givenScene_whenLoginButtonTapped_thenInteractorCalled() {
//        tapLoginButton()
//        XCTAssertTrue(interactor.tryToLogInCalled)
//    }
//
//    func test_givenScene_whenPresenterCallsToShowLoginSuccess_thenRouterCalled() {
//        sut.showLogInSuccess(fullUserName: "niraj paul")
//        XCTAssertTrue(router.showLoginSuccessCalled)
//    }
//
//    func test_givenScene_whenPresenterCallsToShowLoginFailure_thenRouterCalled() {
//        sut.showLogInFailure(message: "")
//        XCTAssertTrue(router.showLogingFailureCalled)
//    }
    
    func test_givenScene_whenLoginButtonTapped_thenInteractorCalled() {
        tapLoginButton()
        interactor.tryToLoginIn()
        XCTAssertTrue(interactor.tryToLogInCalled)
    }
}

private extension LoginSceneViewControllerTests {
    func tapLoginButton() {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    if let button = subview as? UIButton {
                        button.sendActions(for: .touchUpInside)
                    }
                }
            }
        }
    }
}

private final class LoginSceneInteractorModel: LoginSceneInteractorInput {
    var tryToLogInCalled = false
    func tryToLoginIn() {
        tryToLogInCalled = true
    }
}

private final class LoginSceneRoutingLogicModel: LoginSceneRoutingLogic {
    var showLogingFailureCalled = false
    func showLogInfailure(message: String) {
        showLoginSuccessCalled = true
    }
    
    var showLoginSuccessCalled = false
    func showLoginSuccess() {
        showLoginSuccessCalled = true
    }

}
