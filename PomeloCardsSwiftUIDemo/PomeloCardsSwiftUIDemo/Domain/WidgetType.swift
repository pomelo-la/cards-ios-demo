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

extension WidgetType: CaseIterable, Identifiable {
    var id: Int { self.rawValue }
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
        case .changePin: return [WidgetParams.cardId: String.Params.cardId]
        case .card: return [WidgetParams.cardId: String.Params.cardId]
        case .cardDetail: return [WidgetParams.cardId: String.Params.cardId]
        }
    }
}

struct WidgetParams {
    static let cardId = "card_id"
}

fileprivate extension String {
    struct Params {
        /// Hardcoded test user card id
        static let cardId = "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"
    }
}
