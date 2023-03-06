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
    @State var loadSensitiveData: Bool = false
    
    var body: some View {
        Group {
            switch widget {
            case .cardActivation:
                PomeloWidgetCardActivationSwiftUIView(completionHandler: { result in
                    switch result {
                    case .success(let cardId):
                        print("Card was activated. Card id: \(String(describing: cardId))")
                    case .failure(let error):
                        print("Activate card error: \(error)")
                    }
                })
            case .changePin:
                PomeloWidgetChangePinSwiftUIView(params: params, completionHandler: { result in
                    switch result {
                    case .success(): break
                    case .failure(let error):
                        print("Change pin error: \(error)")
                    }
                })
            case .cardDetail: PomeloCardDetailSwiftUIView(loadSensitiveData: $loadSensitiveData,
                                                          params: params,
                                                          onPanCopy: { print("Pan was copied") },
                                                          completionHandler: { result in
                switch result {
                case .success(): break
                case .failure(let error):
                    print("Change pin error: \(error)")
                }
            })
            case .card: CardContainerView(loadSensitiveData: $loadSensitiveData,
                                          params: params,
                                          cardholder: "Juan Perez",
                                          lastFourDigits: "3636",
                                          imageFetcher: PomeloImageFetcher(image: UIImage(named: "TarjetaVirtual")!),
                                          onPanCopy: { print("Pan was copied") },
                                          completionHandler: { result in
                                              switch result {
                                              case .success(): break
                                              case .failure(let error):
                                                  print("Sensitive data error: \(error)")
                                              }
                                          })
            }
        }.onAppear(perform: {
            loadSensitiveData = true
        })
    }
}

// MARK: - Helpers for factory methods

extension PomeloWidgetChangePinSwiftUIView {
    init?(params: [String : Any], completionHandler: @escaping (Result<Void, PomeloError>) -> Void) {
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        self.init(cardId: cardId, completionHandler: completionHandler)
    }
}

extension PomeloCardDetailSwiftUIView {
    init?(loadSensitiveData: Binding<Bool>,
          params: [String : Any],
          onPanCopy: (() -> Void)? = nil,
          completionHandler: @escaping (Result<Void, PomeloError>) -> Void) {
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        self.init(cardId: cardId,
                  onPanCopy: onPanCopy,
                  completionHandler: completionHandler,
                  loadSensitiveData: loadSensitiveData)
    }
}

extension CardContainerView {
    init?(loadSensitiveData: Binding<Bool>,
          params: [String : Any],
          cardholder: String,
          lastFourDigits: String,
          imageFetcher: PomeloUIImageFetchable,
          onPanCopy: (() -> Void)? = nil,
          completionHandler: @escaping (Result<Void, PomeloError>) -> Void) {
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        self.cardViewBuilder = { loadData in
                PomeloCardSwiftUIView(cardholder: cardholder,
                                      lastFourDigits: lastFourDigits,
                                      imageFetcher: imageFetcher,
                                      cardId: cardId,
                                      onPanCopy: onPanCopy,
                                      completionHandler: completionHandler,
                                      loadSensitiveData: loadData)
        }
    }
}
