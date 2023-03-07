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
  
  
  /// Setup cards sdk, it sets up the environment, the authorization service and the theme.
  /// - Parameter email: User's email
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
  
  
  /// Bridge to launch the card list widget on react native.
  /// - Parameters:
  ///   - cardId: Id of the cards
  ///   - resolve: Promise that handles the success scenario
  ///   - reject: Promise that handles the failure scenario
  @objc func launchCardListWidget(_ cardId: String,
                                  resolver resolve: @escaping RCTPromiseResolveBlock,
                                  rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    guaranteeMainThread {
      guard let presenterViewController = PomeloCardsModule.presenterViewController(reject: reject) else { return }
      let widgetDetailViewController = PomeloCardWidgetDetailViewController()
      presenterViewController.displayViewControllerAsBottomSheet(widgetDetailViewController)
      widgetDetailViewController.showSensitiveData(cardId: cardId) {
        // Cannot have 3 callbacks on the same method currently -> https://github.com/facebook/react-native/issues/29860"
      } completionHandler: { result in
        switch result {
        case .success: resolve(nil)
        case .failure(let error): reject("0", "Failed to load sensitive data", error)
        }
      }
    }
  }
  
  
  /// Bridge to launch the change pin widget on react native.
  /// - Parameters:
  ///   - cardId: Id of the cards
  ///   - resolve: Promise that handles the success scenario
  ///   - reject: Promise that handles the failure scenario
  @objc func launchChangePinWidget(_ cardId: String,
                                   resolver resolve: @escaping RCTPromiseResolveBlock,
                                   rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    guaranteeMainThread {
      guard let presenterViewController = PomeloCardsModule.presenterViewController(reject: reject) else { return }
      let widgetChangePinViewController = PomeloWidgetChangePinViewController(cardId: cardId, completionHandler: { result in
          switch result {
          case .success(): presenterViewController.dismiss(animated: true) { resolve(nil) }
          case .failure(let error): reject("0", "Failed to change pin", error)
          }
      })
      presenterViewController.present(widgetChangePinViewController, animated: true)
    }
  }
  
  /// Bridge to launch the activate card widget on react native.
  /// - Parameters:
  ///   - resolve: Promise that handles the success scenario
  ///   - reject: Promise that handles the failure scenario
  @objc func launchActivateCardWidget(_  resolve: @escaping RCTPromiseResolveBlock,
                                      rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    guaranteeMainThread {
      guard let presenterViewController = PomeloCardsModule.presenterViewController(reject: reject) else { return }
      let widgetCardActivationViewController =  PomeloWidgetCardActivationViewController(completionHandler: { result in
          switch result {
          case .success(let cardId): presenterViewController.dismiss(animated: true) { resolve(cardId) }
          case .failure(let error): reject("0", "Failed to activate card", error)
          }
      })
      presenterViewController.present(widgetCardActivationViewController, animated: true)
    }
  }
  
  private static func presenterViewController(reject: RCTPromiseRejectBlock) -> UIViewController? {
    guard let presenterViewController = UIApplication.shared.windows.first?.rootViewController else {
      let rejectParams = NSError.cardsError.rejectParams(message: "Cannot find navigation controller")
      reject(rejectParams.0, rejectParams.1, rejectParams.2)
      return nil
    }
    return presenterViewController
  }
}

// MARK: - Helpers

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
