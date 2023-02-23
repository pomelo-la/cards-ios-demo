//
//  WidgetSwiftUIFactory.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 23/02/2023.
//

import Foundation
import SwiftUI
import PomeloCards

struct WidgetView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    let widget: WidgetType
    let params: [String: Any]
    let factory: WidgetViewControllerFactoryProtocol = WidgetViewControllerFactory()
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = factory.buildWidgetController(for: widget, params: params)
        return vc ?? UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

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
            #warning("Must add this view created in SwiftUI")
            return nil
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
