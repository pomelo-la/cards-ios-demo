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
            case .cardDetail: PomeloCardDetailWidget(loadSensitiveData: $loadSensitiveData,
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

extension PomeloCardDetailWidget {
    init?(loadSensitiveData: Binding<Bool>,
          params: [String : Any],
          onPanCopy: (() -> Void)? = nil,
          completionHandler: @escaping (Result<Void, PomeloError>) -> Void) {
        guard let cardId = params[WidgetParams.cardId] as? String else { return nil }
        self.cardId = cardId
        self.onPanCopy = onPanCopy
        self.completionHandler = completionHandler
        self._loadSensitiveData = loadSensitiveData
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
            PomeloCardView(cardholder: cardholder,
                           lastFourDigits: lastFourDigits,
                           imageFetcher: imageFetcher,
                           cardId: cardId,
                           onPanCopy: onPanCopy,
                           completionHandler: completionHandler,
                           loadSensitiveData: loadData)
        }
    }
}

// MARK: - Views that will be publicly available on Cards SDK
//
//public struct PomeloCardActivationWidget: UIViewControllerRepresentable {
//    typealias UIViewControllerType = PomeloWidgetCardActivationViewController
//    let completionHandler: (Result<String?, PomeloError>) -> Void
//
//    func makeUIViewController(context: Context) -> PomeloWidgetCardActivationViewController {
//        PomeloWidgetCardActivationViewController(completionHandler: completionHandler)
//    }
//
//    func updateUIViewController(_ uiViewController: PomeloWidgetCardActivationViewController, context: Context) {}
//}
//
//public struct PomeloCardPinWidget: UIViewControllerRepresentable {
//    typealias UIViewControllerType = PomeloWidgetChangePinViewController
//    let cardId: String
//    let completionHandler: (Result<Void, PomeloError>) -> Void
//
//    func makeUIViewController(context: Context) -> PomeloWidgetChangePinViewController {
//        PomeloWidgetChangePinViewController(cardId: cardId, completionHandler: completionHandler)
//    }
//
//    func updateUIViewController(_ uiViewController: PomeloWidgetChangePinViewController, context: Context) {}
//}

struct PomeloCardDetailWidget: UIViewControllerRepresentable {
    typealias UIViewControllerType = PomeloCardWidgetDetailViewController
    let cardId: String
    let onPanCopy: (() -> Void)?
    let completionHandler: (Result<Void, PomeloError>) -> Void
    @Binding var loadSensitiveData: Bool
    
    func makeUIViewController(context: Context) -> PomeloCardWidgetDetailViewController {
        PomeloCardWidgetDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: PomeloCardWidgetDetailViewController, context: Context) {
        if loadSensitiveData {
            uiViewController.showSensitiveData(cardId: cardId, onPanCopy: onPanCopy) { result in
                completionHandler(result)
                loadSensitiveData = false
            }
        }
    }
}

struct PomeloCardView: UIViewRepresentable {
    typealias UIViewType = PomeloCardWidgetView
    let cardholder: String
    let lastFourDigits: String
    let imageFetcher: PomeloUIImageFetchable
    let cardId: String
    let onPanCopy: (() -> Void)?
    let completionHandler: (Result<Void, PomeloError>) -> Void
    @Binding var loadSensitiveData: Bool
    
    func makeUIView(context: Context) -> PomeloCardWidgetView {
        PomeloCardWidgetView(cardholderName: cardholder, lastFourCardDigits: lastFourDigits, imageFetcher: imageFetcher)
    }
    
    func updateUIView(_ uiView: PomeloCardWidgetView, context: Context) {
        if loadSensitiveData {
            uiView.showSensitiveData(cardId: cardId, onPanCopy: onPanCopy) { result in
                completionHandler(result)
                loadSensitiveData = false
            }
        }
    }
}
