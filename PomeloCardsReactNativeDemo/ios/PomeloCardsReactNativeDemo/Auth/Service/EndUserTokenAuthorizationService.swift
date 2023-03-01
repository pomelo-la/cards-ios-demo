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
    private let email: String
    private let endUserTokenResolver: UserEmailEndUserTokenResolverProtocol
    
    init(email: String,
         endUserTokenResolver: UserEmailEndUserTokenResolverProtocol = UserEmailEndUserTokenResolver()) {
        self.email = email
        self.endUserTokenResolver = endUserTokenResolver
    }
    
    /// Function that gets a valid token from a service asynchronously. Method required by `PomeloAuthorizationServiceProtocol`
    /// - Parameter completionHandler: A closure that returns a end user token if it was able to retrieve one
    func getValidToken(completionHandler: @escaping (String?) -> Void) {
        self.endUserTokenResolver.resolve(email: self.email) { endUserToken in
            guard let endUserToken = endUserToken else {
                print("Cards Sample App error!🔥 Cannot obtain user token")
                completionHandler(nil)
                return
            }
            completionHandler(endUserToken)
        }
    }
}
