//
//  Enums.swift
//  PomeloCardsDemo
//
import Foundation
import UIKit

enum CollectionViewCellTypes: Int {
    case cardActivation = 0
    case changePin = 1
    case sensitiveData = 2
    
    func getTitle() -> String {
        switch self {
        case .cardActivation: return "Activación de tarjeta"
        case .changePin: return "Cambio de pin"
        case .sensitiveData: return "Mostrar información sensible"
        }
    }
}
