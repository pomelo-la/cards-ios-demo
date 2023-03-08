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
  
  /// Bridge to call  `showSensitiveData` method of `PomeloCardWidgetView` from  react native.
  /// - Parameters:
  ///   - reactTag: Tag of the react view on the react native side.
  ///   - cardId: Id of the cards
  ///   - resolve: Promise that handles the success scenario
  ///   - reject: Promise that handles the failure scenario
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
        // Cannot have 3 callbacks on the same method currently -> https://github.com/facebook/react-native/issues/29860"
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
  /// Helper required to setup the view based on React Native params
  /// - Parameter params: Dictionary with expected params for the setup: `cardholderName`, `lastFourCardDigits` and `image`.
  /// `cardholderName`: String with the cardholder name.
  /// `lastFourCardDigits`: String with the last four digits of the credit card,
  /// `image`: String representing the image, it can be a image url or a local image name.
  @objc func setSetupParams(_ params: NSDictionary) {
    guard let cardholderName = params["cardholderName"] as? String,
          let lastFourCardDigits = params["lastFourCardDigits"] as? String,
          let imageParam = params["image"] as? String else {
      RCTLogError("Missing required params: `cardholderName`, `lastFourCardDigits` and `image`")
      return
    }
    
    guard let imageFetcher = PomeloImageFetcher(imageParam: imageParam) else {
      RCTLogError("Not valid image parameter: \(imageParam)")
      return
    }
    
    self.setup(cardholderName: cardholderName,
               lastFourCardDigits: lastFourCardDigits,
               imageFetcher: imageFetcher)
  }
}


extension PomeloImageFetcher {
  
  /// Helper that creates a `PomeloImageFetcher` from a image url or a local image name.
  /// - Parameter imageParam: String representing the image, it can be a image url or a local image name.
  init?(imageParam: String) {
    if let imageUrl = imageParam.imageUrl {
      if imageUrl.pathExtension == "pdf" {
        self.init(pdfImage: imageUrl)
      } else {
        self.init(url: imageUrl)
      }
    } else if let image =  UIImage(named: imageParam) {
      self.init(image: image)
    } else {
      return nil
    }
  }
}

fileprivate extension String {
    var imageUrl: URL? {
      if let url = URL(string: self),
         UIApplication.shared.canOpenURL(url) {
          return url
      }
      return nil
    }
}
