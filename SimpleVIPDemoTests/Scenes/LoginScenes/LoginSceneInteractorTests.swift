//
//  LoginSceneInteractorTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
@testable import SimpleVIPDemo

final class LoginSceneInteractorTests: XCTestCase {
    private var sut: LoginSceneInteractor!
    private var worker: LoginSceneAuthWorkerMock!
    private var presenter: LoginScenePresenterInputMock!
    
    override func setUp() {
        super.setUp()
        
        sut = LoginSceneInteractor()
        worker = LoginSceneAuthWorkerMock()
        presenter = LoginScenePresenterInputMock()
        sut.presenter = presenter
        sut.authWorker = worker
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func test_givenInteractor_whenTryToLogInCalled_thenWorkerCalled() {
        sut.tryToLoginIn()
        XCTAssertTrue(worker.makeAuthCalled)
    }
}

private final class LoginSceneAuthWorkerMock: LoginSceneAuthLogic {
    var makeAuthStub: Result<CleanLoginUser, LoginSceneAuthWorker.LoginSceneAuthWorkerError>?
    var makeAuthCalled = false
    
    func makeAuth(completion: @escaping (Result<CleanLoginUser, LoginSceneAuthWorker.LoginSceneAuthWorkerError>) -> Void) {
        makeAuthCalled = true
        if let stub = makeAuthStub {
            completion(stub)
        }
    }
}

private final class LoginScenePresenterInputMock: LoginScenePresenterInput {
    var showLogingSuccessCalled = false
    var showLogingSuccessData: CleanLoginUser!
    func showLogingSuccess(user: CleanLoginUser) {
        showLogingSuccessCalled = true
        showLogingSuccessData = user
    }
    
    var showLogingFailureCalled = false
    var showLogingFailureMessage: String!
    func showLogingFailure(message: String) {
        showLogingFailureCalled = true
        showLogingFailureMessage = message.debugDescription.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
