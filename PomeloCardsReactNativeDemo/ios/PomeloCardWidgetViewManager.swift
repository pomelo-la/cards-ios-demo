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
}

extension PomeloCardWidgetView {
  @objc public func setSetupParams(_ params: NSDictionary) {
      guard let cardholderName = params["cardholderName"] as? String,
            let lastFourCardDigits = params["lastFourCardDigits"] as? String else {
        return
      }
      self.setup(cardholderName: cardholderName, lastFourCardDigits: lastFourCardDigits, imageFetcher: PomeloImageFetcher(image: UIImage(named: "tarjetaVirtual")!))
  }
}
