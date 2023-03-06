//
//  PomeloCardsModule.swift
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 01/03/2023.
//

import Foundation
import UIKit
import PomeloUI
import PomeloNetworking
import PomeloCards

@objc(PomeloCardsModule)
class PomeloCardsModule: NSObject {
  
  @objc func setupSDK(_ email: String) {
    //Configure Cards SDK
    PomeloCards.initialize(with: PomeloCardsConfiguration(environment: .staging))
    //Configure authorization service on PomeloNetworking
    PomeloNetworkConfigurator.shared.configure(authorizationService: EndUserTokenAuthorizationService(email: email))
    guaranteeMainThread {
      //Configure theme on PomeloUI
      PomeloUIGateway.shared.configure(theme: PomeloTheme())
    }
  }
  
  @objc func launchCards(_ resolve: @escaping RCTPromiseResolveBlock,
                         rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    guaranteeMainThread {
      guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
        let rejectParams = NSError.cardsError.rejectParams(message: "Cannot find navigation controller")
        reject(rejectParams.0, rejectParams.1, rejectParams.2)
        return
      }
      PomeloCards.launchCards(on: viewController)
      resolve(true)
    }
  }
  
  @objc func launchCardListWidget(_ cardId: String,
                                  resolver resolve: @escaping RCTPromiseResolveBlock,
                                  rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    guaranteeMainThread {
      guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
        let rejectParams = NSError.cardsError.rejectParams(message: "Cannot find navigation controller")
        reject(rejectParams.0, rejectParams.1, rejectParams.2)
        return
      }
      let widgetDetailViewController = PomeloCardWidgetDetailViewController()
      viewController.displayViewControllerAsBottomSheet(widgetDetailViewController)
      widgetDetailViewController.showSensitiveData(cardId: cardId) {
        // TODO: Cannot have 3 callbacks on the same method currently -> https://github.com/facebook/react-native/issues/29860"
      } completionHandler: { result in
        switch result {
        case .success:
          resolve(nil)
        case .failure(let error):
          reject("0", "Failed to load sensitive data", error)
        }
      }
    }
  }
  
  
}


extension NSError {
  static var cardsError: NSError {
    NSError(domain: "E_CARDS", code: 0)
  }
  
  func rejectParams(message: String) -> (String, String, NSError) {
    ("\(self.code)", message, self)
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
