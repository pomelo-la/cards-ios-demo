//
//  BlueClientTheme.swift
//  CardsSampleApp
//
//  Created by Oscar Odon on 08/06/2022.
//

import Foundation
import UIKit
import PomeloUI

class BlueClientTheme: PomeloThemeable {
    var colors: PomeloColors = PomeloColors(primary: .primaryColor,
                                            secondary: .secondaryColor,
                                            background: .backgroundColor)
    
    var buttons: PomeloButtonsStyle = PomeloButtonsStyle(
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
    
    var feedbacks: PomeloFeedback?
    
    var text: PomeloTextStyle? = .init(textColor: .label,
                                       font: nil)
}

private extension UIColor {
    static var primaryColor: UIColor {
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? UIColor(red: 0.07, green: 0.39, blue: 0.87, alpha: 1.00) : UIColor(red: 0.07, green: 0.39, blue: 0.87, alpha: 0.75)
        }
    }
    
    static var secondaryColor: UIColor {
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? UIColor(red: 0.28, green: 0.71, blue: 1.00, alpha: 1.00) : UIColor(red: 0.28, green: 0.71, blue: 1.00, alpha: 0.80)
        }
    }
    
    static var backgroundColor: UIColor {
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? UIColor(red: 0.87, green: 0.96, blue: 1.00, alpha: 1.00) : UIColor(red: 0.02, green: 0.16, blue: 0.24, alpha: 1.00)
        }
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
