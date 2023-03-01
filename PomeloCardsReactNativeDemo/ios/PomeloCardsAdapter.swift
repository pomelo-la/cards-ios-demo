//
//  PomeloCardsAdapter.swift
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 01/03/2023.
//

import Foundation
import UIKit
import PomeloUI
import PomeloNetworking
import PomeloCards

@objc(PomeloCardsAdapter)
class PomeloCardsdapter: NSObject {
  @objc func launchCards(_ resolve: @escaping RCTPromiseResolveBlock,
                         rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    guaranteeMainThread {
      guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
        let error = NSError.cardsError
        reject("\(error.code)", "Cannot find navigation controller", error)
        return
      }
      self.setupPomeloCards()
      PomeloCards.launchCards(on: viewController)
      resolve(true)
    }
  }
  
  private func setupPomeloCards() {
    //Configure Cards SDK
    PomeloCards.initialize(with: PomeloCardsConfiguration(environment: .staging))
    //Configure authorization service on PomeloNetworking
    PomeloNetworkConfigurator.shared.configure(authorizationService: EndUserTokenAuthorizationService())
    //Configure theme on PomeloUI
    PomeloUIGateway.shared.configure(theme: PomeloTheme())
  }
}

extension NSError {
  static var cardsError: NSError {
    NSError(domain: "E_CARDS", code: 0)
  }
}

extension NSObject {
  func guaranteeMainThread(_ work: @escaping () -> Void) {
    if Thread.isMainThread {
      work()
    } else {
      DispatchQueue.main.async(execute: work)
    }
  }
}
