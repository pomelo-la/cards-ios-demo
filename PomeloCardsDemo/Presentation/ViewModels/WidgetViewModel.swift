//
//  WidgetViewModel.swift
//  PomeloCardsDemo
//

import Foundation
import UIKit
import PomeloCards

protocol WidgetViewModelProtocol {
    func getWidgetController(for widget: WidgetType) -> UIViewController?
    func configCell(_ cell: WidgetTableViewCell, widget: WidgetType)
}

class WidgetViewModel: WidgetViewModelProtocol {
    
    private var widgetsFactory: WidgetViewControllerFactoryProtocol = WidgetViewControllerFactory()
     
    func getWidgetController(for widget: WidgetType) -> UIViewController? {
        widgetsFactory.buildWidgetController(for: widget, params: widget.getParams())
    }
    
    func configCell(_ cell: WidgetTableViewCell, widget: WidgetType) {
        cell.titleLabel.text = widget.getTitle()
    }
}

extension WidgetType {
    func getTitle() -> String {
        switch self {
        case .cardActivation: return "Activación de tarjeta"
        case .changePin: return "Cambio de pin"
        case .card: return "Tarjeta"
        case .cardDetail: return "Datos de tarjeta"
        }
    }
    
    func getParams() -> [String: Any] {
        switch self {
        case .cardActivation: return [:]
        case .changePin: return ["card_id": "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"]
        case .card: return ["card_id": "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"]
        case .cardDetail: return ["card_id": "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"]
        }
    }
}
    
