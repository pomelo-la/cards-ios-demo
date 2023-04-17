//
//  PomeloCardsTheme.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 08/06/2022.
//

import Foundation
import UIKit
import PomeloCards

class PomeloCardsTheme: PomeloCardsThemeable {
    var colors: PomeloCardsColors = PomeloCardsColors(primary: .primaryColor,
                                            secondary: .secondaryColor,
                                            background: .backgroundColor)
    
    var buttons: PomeloCardsButtonsStyle = PomeloCardsButtonsStyle(
        primary: .init(
            cornerRadius: 10,
            enabledStyle: .init(backgroundColor: .primaryColor, foregroundColor: .butttonForegroundColor),
            disabledStyle: .init(backgroundColor: .disabledButtonBackgroundColor,foregroundColor:  .disabledButtonForegroundColor)
        ),
        secondary: .init(
            cornerRadius: 10,
            enabledStyle: .init(backgroundColor: .secondaryColor,foregroundColor: .primaryColor),
            disabledStyle: .init(backgroundColor: .secondaryColor, foregroundColor: .disabledButtonForegroundColor)
        ),
        tertiary: .init(
            cornerRadius: 0,
            enabledStyle: .init(backgroundColor: .clear, foregroundColor: .primaryColor),
            disabledStyle: .init(backgroundColor: .clear, foregroundColor: .disabledButtonForegroundColor)
        ),
        link: .init(
            cornerRadius: 0,
            enabledStyle: .init(backgroundColor: .clear, foregroundColor: .primaryColor),
            disabledStyle: .init(backgroundColor: .clear, foregroundColor: .disabledButtonForegroundColor)
        )
    )
    
    var feedbacks: PomeloCardsFeedback?
    
    var text: PomeloCardsTextStyle? = .init(textColor: .label,
                                       font: nil)
}

private extension UIColor {
    static var primaryColor: UIColor {
        UIColor(red: 0.902, green: 0.118, blue: 0.4, alpha: 1)
    }
    
    static var secondaryColor: UIColor {
        UIColor(red: 0.902, green: 0.118, blue: 0.4, alpha: 0.15)
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
