//
//  WidgetViewModel.swift
//  PomeloCardsDemo
//

import Foundation
import UIKit
import PomeloCards

protocol WidgetViewModelProtocol {
    func launchWidgetController(by index: Int) -> UIViewController?
}

class WidgetViewModel: WidgetViewModelProtocol {
    
    private let params: [String: Any] = ["card_id": "someCardID"]
    
    func launchWidgetController(by index: Int) -> UIViewController? {
        switch index {
        case CollectionViewCellTypes.cardActivation.rawValue:
            return getActivationCardWidget()
        case CollectionViewCellTypes.changePin.rawValue:
            return getPinWidget()
        case CollectionViewCellTypes.sensitiveData.rawValue:
            return getCard()
        default: return UIViewController()
        }
    }
    
    private func getActivationCardWidget() -> UIViewController? {
        return nil
    }
    
    private func getPinWidget() -> UIViewController? {
        return nil
    }
    
    private func getCard() -> UIViewController? {
        
        guard let cardId = params["card_id"] as? String else { return nil }
        let widgetView = PomeloCardWidgetView(settings: PomeloCardWidgetViewSettings(cardholderName: "Juan Perez",
                                                                         lastFourCardDigits: "3636",
                                                                         cardImage: UIImage(named: "TarjetaVirtual")))
        return CardController(cardWidgetView: widgetView, cardId: cardId)
        
    }
}
