//
//  WidgetType.swift
//  PomeloCardsDemo
//
import Foundation

enum WidgetType: Int {
    case cardActivation = 0
    case changePin
    case card
    case cardDetail
}

extension WidgetType: CaseIterable {
    static let count: Int = {
        allCases.count
    }()
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
