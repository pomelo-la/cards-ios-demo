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
    
    /// Function that returns a valid end user token. This function is sync, usually this token is provided by a backend asynchronously. Here is an example of how you can implement it by using out `FunctionConverter`
    /// - Returns: End user token
    func getValidToken() -> String {
        return FunctionConverter.asyncToSync(function: getUserToken) ?? ""
    }
    
    
    /// Funtion that gets a valid token from a service asynchronously
    /// - Parameter completion: A closure that returns a end user token if it was able to retrieve one
    private func getUserToken(completion: @escaping (String?) -> Void) {
        guard let userEmail = self.emailProvider.provideCurrentUserEmail() else {
            print("Cards Sample App error!🔥 - UserTokenService: Couldn't get user email")
            completion(nil)
            return
        }
        self.endUserTokenResolver.resolve(email: userEmail) { endUserToken in
            guard let endUserToken = endUserToken else {
                print("Cards Sample App error!🔥 Cannot obtain user token")
                completion(nil)
                return
            }
            completion(endUserToken)
        }
    }
}
