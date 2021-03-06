//
//  LoginSceneInteractor.swift
//  CleanVIPA
//
//  Created by Niraj Paul on 19/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

typealias LoginSceneInteractorInput = LoginSceneViewControllerOutPut

protocol LoginInteractorOutput: AnyObject {
  func showLogingSuccess(user: CleanLoginUser)
  func showLogingFailure(message: String)
}
final class LoginSceneInteractor {
    var presenter: LoginScenePresenterInput?
    var authWorker: LoginSceneAuthLogic?
}

extension LoginSceneInteractor:LoginSceneInteractorInput {
    func tryToLoginIn() {
        authWorker?.makeAuth(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.presenter?.showLogingSuccess(user: data)
                case .failure(let error):
                    self.presenter?.showLogingFailure(message: error.localizedDescription)
                }
            }
        })
    }
}
