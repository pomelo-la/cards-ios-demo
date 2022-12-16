//
//  SceneDelegate.swift
//  PomeloCardsDemo
//
//  Created by Fernando Pena on 15/12/2022.
//

import UIKit
import PomeloCards
import PomeloUI
import PomeloNetworking

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        self.window = UIWindow(windowScene: windowScene)
        setupWindow()
        setupPomeloCards()
    }

    private func setupWindow() {
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
    }
    
    private func setupPomeloCards() {
        //Configure Cards SDK
        PomeloCards.initialize(with: PomeloCardsConfiguration(environment: .staging))
        //Configure authorization service on PomeloNetworking
        PomeloNetworkConfigurator.shared.configure(authorizationService: EndUserTokenAuthorizationService())
        //Configure theme on PomeloUI
        PomeloUIGateway.shared.initialize()
    }

}

