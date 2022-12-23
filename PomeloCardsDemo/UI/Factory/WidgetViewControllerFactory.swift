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
            return getCard(params: params)
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
        guard let cardId = params["card_id"] as? String else { return nil }
        let widgetChangePinViewController = PomeloWidgetChangePinViewController(cardId: cardId, completionHandler: { result in
            switch result {
            case .success(): break
            case .failure(let error):
                print("Change pin error: \(error)")
            }
        })
        return widgetChangePinViewController
    }
    
    private func getCard(params: [String: Any]) -> UIViewController? {
        
        guard let cardId = params["card_id"] as? String else { return nil }
        let widgetView = PomeloCardWidgetView(cardholderName: "Juan Perez",
                                              lastFourCardDigits: "3636",
                                              cardImage: UIImage(named: "TarjetaVirtual"))
        return CardViewController(cardWidgetView: widgetView, cardId: cardId)
        
    }
    
    private func getCardList(params: [String: Any]) -> UIViewController? {
        guard let cardId = params["card_id"] as? String else { return nil }
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
