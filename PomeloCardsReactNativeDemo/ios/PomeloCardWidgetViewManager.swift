//
//  PomeloCardWidgetViewManager.swift
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 02/03/2023.
//

import Foundation
import UIKit
import PomeloCards

@objc(PomeloCardWidgetViewManager)
class PomeloCardWidgetViewManager: RCTViewManager {
  override func view() -> UIView! {
    let view = PomeloCardWidgetView()
    return view
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc func showSensitiveData(_ reactTag: NSNumber,
                               cardId: String,
                               resolver resolve: @escaping RCTPromiseResolveBlock,
                               rejecter reject: @escaping RCTPromiseRejectBlock
  ) {
    self.bridge.uiManager.addUIBlock { uiManager, viewRegistry in
      guard let view = viewRegistry?[reactTag] as? PomeloCardWidgetView else {
        let error = NSError.cardsError
        reject("\(error.code)", "Cannot find NativeView with tag \(reactTag)", error)
        return
      }
      view.showSensitiveData(cardId: cardId) {
        // TODO: Cannot have 3 callbacks on the same method currently -> https://github.com/facebook/react-native/issues/29860"
      } completionHandler: { result in
        switch result {
        case .success:
          resolve(true)
        case .failure(let error):
          reject("0", "Failed to load sensitive data", error)
        }
      }
    }
  }
}

extension PomeloCardWidgetView {
  @objc public func setSetupParams(_ params: NSDictionary) {
      guard let cardholderName = params["cardholderName"] as? String,
            let lastFourCardDigits = params["lastFourCardDigits"] as? String else {
        // TODO: Bridge `RCTLog` to swift world
        // RCTLogError(@"Missing required params: `cardholderName` and `lastFourCardDigits`")
        return
      }
      self.setup(cardholderName: cardholderName,
                 lastFourCardDigits: lastFourCardDigits,
                 imageFetcher: PomeloImageFetcher(image: UIImage(named: "tarjetaVirtual")!))
  }
  
}
