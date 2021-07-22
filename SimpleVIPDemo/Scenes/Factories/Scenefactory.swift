//
//  Scenefactory.swift
//  CleanVIPA
//
//  Created by Niraj Paul on 19/07/21.
//


import UIKit

protocol SceneFactory {
    var configurator: LoginSceneConfigurator! { get set}
    func makeLoginScene()-> UIViewController
}
final class DefaultSceneFactory: SceneFactory {
    var configurator: LoginSceneConfigurator!
    
    func makeLoginScene() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let controller = storyboard.instantiateViewController(withIdentifier:
            "LoginViewController") as? LoginViewController
        return configurator.configured(controller!)
    }
}
