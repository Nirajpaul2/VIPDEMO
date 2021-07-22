//
//  LoginSceneConfigurator.swift
//  CleanVIPA
//
//  Created by Niraj Paul on 19/07/21.
//

import Foundation
import UIKit
protocol LoginSceneConfigurator {
    func configured(_ vc: LoginViewController) -> LoginViewController
}
final class DefaultLoginSceneConfigurator:LoginSceneConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    func configured(_ vc: LoginViewController) -> LoginViewController {
        sceneFactory.configurator = self
        let authWorker = LoginSceneAuthWorker()
        let interactor = LoginSceneInteractor()
        let presenter = LoginScenePresenter()
        let router = LoginSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.authWorker = authWorker
        vc.interactor = interactor
        return vc
    }
}
