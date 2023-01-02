//
//  EndUserTokenResolver.swift
//  CardsSampleApp
//
//  Created by Fernando Pena on 10/11/2022.
//

import Foundation
import PomeloNetworking


/// Protocol with the method that retrieves a end user token for a given user email asynchronously
protocol UserEmailEndUserTokenResolverProtocol {
    func resolve(email: String, completion: @escaping (String?) -> Void)
}


/// Implementation of `UserEmailEndUserTokenResolverProtocol` using an sample backend service.
class UserEmailEndUserTokenResolver: UserEmailEndUserTokenResolverProtocol {
    
    func resolve(email: String, completion: @escaping (String?) -> Void) {
        let session = URLSession.shared
        guard let urlRequest = buildRequest(email: email) else {
            print("\(String.userTokenError) cannot build request")
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("\(String.userTokenError) \(error)")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let dto = try decoder.decode(PomeloAccessTokenDTO.self, from: data!)
                completion(dto.accessToken)
            } catch {
                print("\(String.userTokenError) \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func buildRequest(email: String) -> URLRequest? {
        let url = URL.endUserSampleApiBaseURL.appendingPathComponent("token")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = [
            String.BodyParams.email: "\(email)"
        ]
        
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .withoutEscapingSlashes
            urlRequest.httpBody = try jsonEncoder.encode(body)
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: String.AuthHeaders.contentType)
        
        return urlRequest
    }
}


fileprivate extension String {
    static let userTokenError = "Cards Demo App error!🔥 - EndUserTokenService: "

    struct AuthHeaders {
        static let contentType = "Content-Type"
    }
    
    struct BodyParams {
        static let email = "email"
    }
}


fileprivate extension URL {
    static let endUserSampleApiBaseURL = URL(string: "https://api-stage.pomelo.la/cards-sdk-be-sample")!
}
