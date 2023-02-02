//
//  WidgetViewControllerFactory.swift
//  PomeloCardsDemo
//
//  Created by Fernando Pena on 23/12/2022.
//

import Foundation
import UIKit
import PomeloCards

protocol WidgetViewControllerFactoryProtocol {
    func buildWidgetController(for widget: WidgetType, params: [String: Any]) -> UIViewController?
}

class WidgetViewControllerFactory: WidgetViewControllerFactoryProtocol {
    
    func buildWidgetController(for widget: WidgetType, params: [String: Any]) -> UIViewController? {
        switch widget {
        case .cardActivation:
            return getActivationCardWidget(params: params)
        case .changePin:
            return getPinWidget(params: params)
        case .card:
            return getStoryboardCard(params: params)
        case .cardDetail:
            return getCardList(params: params)
        }
    }
    
    private func getActivationCardWidget(params: [String: Any]) -> UIViewController? {
        let widgetCardActivationViewController =  PomeloWidgetCardActivationViewController(completionHandler: { result in
            switch result {
            case .success(let cardId):
                print("Card was activated. Card id: \(String(describing: cardId))")
            case .failure(let error):
                print("Activate card error: \(error)")
            }
        })
        return widgetCardActivationViewController
    }
    
    private func getPinWidget(params: [String: Any]) -> UIViewController? {
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        let widgetChangePinViewController = PomeloWidgetChangePinViewController(cardId: cardId, completionHandler: { result in
            switch result {
            case .success(): break
            case .failure(let error):
                print("Change pin error: \(error)")
            }
        })
        return widgetChangePinViewController
    }
    
    
    /// Creates a `CardViewController` with a `PomeloCardWidgetView` inside. It shows how the client could create a ViewController with a `PomeloCardWidgetView` view by code.
    /// - Parameter params: Params required to create the view controller, Only the cardId is required
    /// - Returns: A `CardViewController` if it was able to generate one.
    private func getCard(params: [String: Any]) -> UIViewController? {

        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        let widgetView = PomeloCardWidgetView(cardholderName: "Juan Perez",
                                              lastFourCardDigits: "3636",
                                              imageFetcher: PomeloImageFetcher(image: UIImage(named: "TarjetaVirtual")!))
        return CardViewController(cardWidgetView: widgetView, cardId: cardId)

    }
    
    /// Creates a `CardStoryboardViewController` with a `PomeloCardWidgetView` inside. It shows how the client could create a ViewController with a `PomeloCardWidgetView` view using a storyboard.
    /// - Parameter params: Params required to create the view controller, Only the cardId is required
    /// - Returns: A `CardStoryboardViewController` if it was able to generate one.
    private func getStoryboardCard(params: [String: Any]) -> UIViewController? {
        
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        let cardViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "CardStoryboardViewController", creator: { coder in
            return CardStoryboardViewController(coder: coder,
                                                cardId: cardId,
                                                cardholderName: "Juan Perez",
                                                lastFourCardDigits: "3636",
                                                cardImage:UIImage(named: "TarjetaVirtual"))
        })
        return cardViewController
    }
    
    private func getCardList(params: [String: Any]) -> UIViewController? {
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        let widgetDetailViewController = PomeloCardWidgetDetailViewController()
        widgetDetailViewController.showSensitiveData(cardId: cardId, onPanCopy: {
            print("Pan was coppied")
        }, completionHandler: { result in
            switch result {
            case .success(): break
            case .failure(let error):
                print("Sensitive data error: \(error)")
            }
        })
        return widgetDetailViewController
    }
}
