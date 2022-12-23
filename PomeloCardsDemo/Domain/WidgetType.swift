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
