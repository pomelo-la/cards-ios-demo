//
//  PomeloAccessTokenDTO.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 09/08/2022.
//

import Foundation

/// Struct with the format of the service token response
/// {
///     "access_token": "kjdsfbadskjfguaid",
///     "expires_in": 4,
///     "token_type": "Bearer"
/// }
struct PomeloAccessTokenDTO: Decodable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}
