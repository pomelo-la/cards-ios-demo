//
//  WidgetViewModel.swift
//  PomeloCardsDemo
//

import Foundation
import UIKit
import PomeloCards

protocol WidgetViewModelProtocol {
    func widgetsCount() -> Int
    func configCell(_ cell: WidgetTableViewCell, widget: WidgetType)
    func presentWidget(_ widget: WidgetType, on viewController: UIViewController)

}

class WidgetViewModel: WidgetViewModelProtocol {
    
    private var widgetsFactory: WidgetViewControllerFactoryProtocol = WidgetViewControllerFactory()
    
    func widgetsCount() -> Int {
        WidgetType.count
    }
    
    func configCell(_ cell: WidgetTableViewCell, widget: WidgetType) {
        cell.titleLabel.text = widget.getTitle()
    }

    func presentWidget(_ widget: WidgetType, on viewController: UIViewController) {
        guard let widgetViewController = widgetsFactory.buildWidgetController(for: widget, params: widget.getParams()) else {
            print("Couldn't generate widget view controller for widget: \(widget)")
            return
        }
        if widget == .cardDetail {
            viewController.displayViewControllerAsBottomSheet(widgetViewController)
        } else {
            viewController.present(widgetViewController, animated: true)
        }
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
    
