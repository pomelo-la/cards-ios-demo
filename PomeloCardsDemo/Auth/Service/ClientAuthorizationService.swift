//
//  CardsAuthorizationService.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 08/08/2022.
//

import Foundation
import PomeloCards
import PomeloNetworking

class EndUserTokenAuthorizationService: PomeloAuthorizationServiceProtocol {
    private let emailProvider: UserEmailProviderProtocol
    private let endUserTokenResolver: UserEmailEndUserTokenResolverProtocol
    
    init(emailProvider: UserEmailProviderProtocol = UserEmailProvider(),
         endUserTokenResolver: UserEmailEndUserTokenResolverProtocol = UserEmailEndUserTokenResolver()) {
        self.emailProvider = emailProvider
        self.endUserTokenResolver = endUserTokenResolver
    }
    
    func getValidToken() -> String {
        var token = ""
        let group = DispatchGroup()

        group.enter()
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.getUserToken { endUserToken in
            
                guard let endUserToken = endUserToken else {
                    print("Cards Sample App error!🔥 Cannot obtain client token")
                    group.leave()
                    return
                }

                token = endUserToken
                group.leave()
            }
        }
        
        group.wait()
        return token
    }
    
    private func getUserToken(completion: @escaping (String?) -> Void) {
        guard let userEmail = self.emailProvider.provideCurrentUserEmail()
        else {
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
