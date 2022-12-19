//
//  FunctionConverter.swift
//  PomeloCardsDemo
//
//  Created by Fernando Pena on 19/12/2022.
//

import Foundation

struct FunctionConverter {
    /// Method that converts a an asynchronous callback function to a synchronous one using `DispatchGroup`
    /// - Parameter function: Function that returns an optional string in a callback
    /// - Returns: Optional string, the same value that would be returned in a callback
    static func asyncToSync(function: @escaping (@escaping (String?) -> Void) -> Void) -> String? {
        var value: String?
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .default).async {
            function { callbackValue in
                value = callbackValue
                group.leave()
            }
        }
        group.wait()
        return value
    }
}
