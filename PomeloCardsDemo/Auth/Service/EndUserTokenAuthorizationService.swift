//
//  EndUserTokenAuthorizationService.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 08/08/2022.
//

import Foundation
import PomeloCards
import PomeloNetworking


/// Client implementation of `PomeloAuthorizationServiceProtocol`. It must return a valid end user token for a given client and user by implementing `func getValidToken() -> String`
class EndUserTokenAuthorizationService: PomeloAuthorizationServiceProtocol {
    private let emailProvider: UserEmailProviderProtocol
    private let endUserTokenResolver: UserEmailEndUserTokenResolverProtocol
    
    init(emailProvider: UserEmailProviderProtocol = UserEmailProvider(),
         endUserTokenResolver: UserEmailEndUserTokenResolverProtocol = UserEmailEndUserTokenResolver()) {
        self.emailProvider = emailProvider
        self.endUserTokenResolver = endUserTokenResolver
    }
    
    /// Funtion that gets a valid token from a service asynchronously. Method required by `PomeloAuthorizationServiceProtocol`
    /// - Parameter completionHandler: A closure that returns a end user token if it was able to retrieve one
    func getValidToken(completionHandler: @escaping (String?) -> Void) {
        guard let userEmail = self.emailProvider.provideCurrentUserEmail() else {
            print("Cards Sample App error!🔥 - UserTokenService: Couldn't get user email")
            completionHandler(nil)
            return
        }
        self.endUserTokenResolver.resolve(email: userEmail) { endUserToken in
            guard let endUserToken = endUserToken else {
                print("Cards Sample App error!🔥 Cannot obtain user token")
                completionHandler(nil)
                return
            }
            completionHandler(endUserToken)
        }
    }
}
