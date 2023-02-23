//
//  WidgetSwiftUIFactory.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 23/02/2023.
//

import Foundation
import SwiftUI
import PomeloCards

protocol WidgetSwiftUIFactoryProtocol {
    func buildWidgetController(for widget: WidgetType, params: [String: Any]) -> WidgetView
}

class WidgetSwiftUIFactory: WidgetSwiftUIFactoryProtocol {
    func buildWidgetController(for widget: WidgetType, params: [String: Any]) -> WidgetView {
        WidgetView(widget: widget, params: widget.getParams())
    }
}

struct WidgetView: View {
    let widget: WidgetType
    let params: [String: Any]
    
    var body: some View {
        Group {
            switch widget {
            case .cardActivation: PomeloCardsActivationWidget(params: params, completionHandler: { result in
                switch result {
                case .success(let cardId):
                    print("Card was activated. Card id: \(String(describing: cardId))")
                case .failure(let error):
                    print("Activate card error: \(error)")
                }
            })
            case .changePin: PomeloCardsPinWidget(params: params, completionHandler: { result in
                switch result {
                case .success(): break
                case .failure(let error):
                    print("Change pin error: \(error)")
                }
            })
            #warning("Should implement other widgets")
            default: EmptyView()
            }
        }
    }
}

// MARK: - Views that will be publicly available on Cards SDK

struct PomeloCardsActivationWidget: UIViewControllerRepresentable {
    typealias UIViewControllerType = PomeloWidgetCardActivationViewController
    let params: [String: Any]
    let completionHandler: (Result<String?, PomeloError>) -> Void
    
    func makeUIViewController(context: Context) -> PomeloWidgetCardActivationViewController {
        let widgetCardActivationViewController =  PomeloWidgetCardActivationViewController(completionHandler: completionHandler)
        return widgetCardActivationViewController
    }
    
    func updateUIViewController(_ uiViewController: PomeloWidgetCardActivationViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

struct PomeloCardsPinWidget: UIViewControllerRepresentable {
    typealias UIViewControllerType = PomeloWidgetChangePinViewController
    let params: [String: Any]
    let completionHandler: (Result<Void, PomeloError>) -> Void
    
    init?(params: [String : Any], completionHandler: @escaping (Result<Void, PomeloError>) -> Void) {
        guard params[WidgetParams.cardId] is String else { return nil }
        self.params = params
        self.completionHandler = completionHandler
    }
    
    func makeUIViewController(context: Context) -> PomeloWidgetChangePinViewController {
        let cardId = params[WidgetParams.cardId] as! String
        let widgetChangePinViewController = PomeloWidgetChangePinViewController(cardId: cardId, completionHandler: completionHandler)
        return widgetChangePinViewController
    }
    
    func updateUIViewController(_ uiViewController: PomeloWidgetChangePinViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
