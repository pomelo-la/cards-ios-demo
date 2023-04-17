//
//  SceneDelegate.swift
//  PomeloCardsDemo
//
//  Created by Fernando Pena on 15/12/2022.
//

import UIKit
import PomeloCards

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupPomeloCards()
    }

    private func setupPomeloCards() {
        //Configure Cards SDK
        PomeloCardsSDK.initialize(with: PomeloCardsConfiguration(environment: .staging))
        //Configure authorization service on PomeloNetworking
        PomeloCardsSDK.setupAuthorizationService(EndUserTokenAuthorizationService())
        //Configure theme on PomeloUI
        PomeloCardsSDK.setupTheme(BlueClientCardsTheme())
    }
}

