//
//  AppDelegate.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 23/02/2023.
//

import UIKit
import PomeloCards
import PomeloUI
import PomeloNetworking

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupPomeloCards()
        return true
    }
    
    private func setupPomeloCards() {
        //Configure Cards SDK
        PomeloCards.initialize(with: PomeloCardsConfiguration(environment: .staging))
        //Configure authorization service on PomeloNetworking
        PomeloNetworkConfigurator.shared.configure(authorizationService: EndUserTokenAuthorizationService())
        //Configure theme on PomeloUI
        PomeloUIGateway.shared.configure(theme: BlueClientTheme())
    }
}
