//
//  VioletClientCardsTheme.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 08/06/2022.
//

import Foundation
import UIKit
import PomeloCards

class VioletClientCardsTheme: PomeloCardsThemeable {
    var colors: PomeloCardsColors = PomeloCardsColors(primary: .primaryColor,
                                            secondary: .secondaryColor,
                                            background: .backgroundColor)
    
    var buttons: PomeloCardsButtonsStyle = PomeloCardsButtonsStyle(
        primary: .init(
            cornerRadius: 10,
            enabledStyle: .init(backgroundColor: .primaryColor, foregroundColor: .white),
            disabledStyle: .init(backgroundColor: .systemGray6, foregroundColor: .systemGray3)
        ),
        secondary: .init(
            cornerRadius: 10,
            enabledStyle: .init(backgroundColor: .secondaryColor, foregroundColor: .primaryColor),
            disabledStyle: .init(backgroundColor: .systemGray6, foregroundColor: .systemGray3)
        ),
        tertiary: .init(
            cornerRadius: 10,
            enabledStyle: .init(backgroundColor: .clear, foregroundColor: .primaryColor),
            disabledStyle: .init(backgroundColor: .clear, foregroundColor: .systemGray3)
        ),
        link: .init(
            cornerRadius: 10,
            enabledStyle: .init(backgroundColor: .clear, foregroundColor: .primaryColor),
            disabledStyle: .init(backgroundColor: .clear, foregroundColor: .systemGray3)
        )
    )
    
    var feedbacks: PomeloCardsFeedback?
    
    var text: PomeloCardsTextStyle? = .init(textColor: .label,
                                       font: nil)
}

private extension UIColor {
    static var primaryColor: UIColor {
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? UIColor(red: 0.30, green: 0.21, blue: 0.46, alpha: 1.00) : UIColor(red: 0.30, green: 0.21, blue: 0.46, alpha: 0.75)
        }
    }
    
    static var secondaryColor: UIColor {
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? UIColor(red: 0.47, green: 0.35, blue: 0.65, alpha: 1.00) : UIColor(red: 0.47, green: 0.35, blue: 0.65, alpha: 0.75)
        }
    }
    
    static var backgroundColor: UIColor {
        .systemBackground
    }
    
    static var buttonBackgroundColor: UIColor {
        .primaryColor
    }
    
    static var butttonForegroundColor: UIColor {
        .white
    }
    
    static var disabledButtonBackgroundColor: UIColor {
        .systemGray6
    }
    
    static var disabledButtonForegroundColor: UIColor {
        .systemGray3
    }
}
