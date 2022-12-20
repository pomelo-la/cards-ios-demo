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
    
    private let params: [String: Any] = ["card_id": "crd-2IBcLQ1m6mL0ZNEyd98eMESmGIK"]
    
    func launchWidgetController(by index: Int) -> UIViewController? {
        switch index {
        case CollectionViewCellTypes.cardActivation.rawValue:
            return getActivationCardWidget()
        case CollectionViewCellTypes.changePin.rawValue:
            return getPinWidget()
        case CollectionViewCellTypes.card.rawValue:
            return getCard()
        case CollectionViewCellTypes.cardDetail.rawValue:
            return getCardList()
        default: return UIViewController()
        }
    }
    
    private func getActivationCardWidget() -> UIViewController? {
        return nil
    }
    
    private func getPinWidget() -> UIViewController? {
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
    
    private func getCard() -> UIViewController? {
        
        guard let cardId = params["card_id"] as? String else { return nil }
        let widgetView = PomeloCardWidgetView(settings: PomeloCardWidgetViewSettings(cardholderName: "Juan Perez",
                                                                         lastFourCardDigits: "3636",
                                                                         cardImage: UIImage(named: "TarjetaVirtual")))
        return CardController(cardWidgetView: widgetView, cardId: cardId)
        
    }
    
    private func getCardList() -> UIViewController? {
        guard let cardId = params["card_id"] as? String else { return nil }
        let widgetDetailViewController = PomeloCardWidgetDetailViewController()
        //viewController.displayViewControllerAsBottomSheet(widgetDetailViewController)
        widgetDetailViewController.loadSensitiveData(cardId: cardId, onPanCopy: {
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
