//
//  Enums.swift
//  PomeloCardsDemo
//
import Foundation
import UIKit

enum CollectionViewCellTypes: Int {
    case cardActivation = 0
    case changePin = 1
    case card = 2
    case cardDetail = 3
    
    func getTitle() -> String {
        switch self {
        case .cardActivation: return "Activación de tarjeta"
        case .changePin: return "Cambio de pin"
        case .card: return "Tarjeta"
        case .cardDetail: return "Datos de tarjeta"
        }
    }
}
