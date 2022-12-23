//
//  UserEmailProvider.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 18/08/2022.
//

import Foundation
import PomeloNetworking

/// Protocol with the methods required to handle clients user session
protocol UserEmailProviderProtocol {
    func userEmailDidChange(to newEmail: String)
    func provideCurrentUserEmail() -> String?
    func clearUserEmailSettings()
}

/// Implementation of `UserEmailProviderProtocol` using `UserDefaults` as session persistance method.
class UserEmailProvider: UserEmailProviderProtocol {
    
    func userEmailDidChange(to newEmail: String) {
        UserDefaults.standard.set(newEmail, forKey: "Email")
        PomeloNetworkConfigurator.shared.userDidChange()
    }
    
    func provideCurrentUserEmail() -> String? {
        return "juan.perez@pomelo.la"
        //UserDefaults.standard.string(forKey: "Email")
    }
    
    func clearUserEmailSettings() {
        UserDefaults.standard.removeObject(forKey: "Email")
    }
}
