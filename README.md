# PomeloCards iOS SDK

![cover](https://user-images.githubusercontent.com/100163572/216343121-17ae2657-f769-4253-9f62-dae0461899c9.jpeg)

<!-- You can make your own custom badges from https://shields.io/ -->
[![Swift](https://img.shields.io/badge/Swift-5.6-orange)](https://img.shields.io/badge/Swift-5.3_5.4_5.5-Orange)
[![Platforms](https://img.shields.io/badge/Platforms-iOS-green)](https://img.shields.io/badge/Platforms-iOS-green)
[![CocoaPods Compatible](https://img.shields.io/badge/Cocoapods-v0.0.1-blue)](https://img.shields.io/badge/Cocoapods-v0.0.1-blue)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)

The **PomeloCards iOS SDK** makes it easy to build a card flows experience in your iOS App. This module provides powerfull customizable UI screens and flows that can be used by any client app to offer a complete cards flow to your customers.

## Table of Content

- [PomeloCards iOS SDK](#pomelocards-ios-sdk)
  - [System Requirements](#system-requirements)
  - [Adding Cards](#adding-cards)
  - [1. Import Dependency](#1-import-dependency)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
  - [2. Register SDK into your Application](#2-register-sdk-into-your-application)
  - [3. Authorization](#3-authorization)
  - [Fully setup sample](#fully-setup-sample)
  - [4. Usage](#4-usage)
  - [Initializing Widgets](#initializing-widgets)
    - [Card](#card)
      - [Summary](#summary)
        - [Public function](#public-function)
          - [init](#init)
          - [showSensitiveData](#showsensitivedata)
    - [Card List Information](#card-list-information)
      - [Summary](#summary-1)
        - [Public function](#public-function-1)
          - [showSensitiveData](#showsensitivedata-1)
    - [Activate Card](#activate-card)
      - [Summary](#summary-2)
        - [Public function](#public-function-2)
          - [init](#init-1)
    - [Change PIN](#change-pin)
      - [Summary](#summary-3)
        - [Public function](#public-function-3)
          - [init](#init-2)
  - [Customizing](#customizing)
  - [Supported Languages](#supported-languages)

-------------

## System Requirements

- iOS 13+
- Xcode 11+
- Swift 5.1+

-------------

## Adding Cards

We support **Cocoapods** and **Swift Package Manager**. If you link the library manually, use a version from our [releases](https://github.com/pomelo-la/cards-ios/releases/) page.

## 1. Import Dependency

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

To add the SDK in your project you just have to follow these steps:

1. In Xcode, select File > Swift Packages > Add Package Dependency and enter <https://github.com/pomelo-la/cards-ios.git> as the repository URL.

2. Select the latest version number from our [releases page](https://github.com/pomelo-la/cards-ios/releases/).

3. Add the PomeloCards product to the [target of your app](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

If you want to add the SDK as a dependency on your swift package follow the next steps:

Once you have your Swift package set up, adding PomeloCards as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "git@github.com:pomelo-la/cards-ios.git", .upToNextMajor(from: "0.1.0"))
]
```

> For details on the latest SDK release and past versions, see the [Releases](https://github.com/pomelo-la/cards-ios/releases/) page on GitHub. To receive notifications when a new release is published, watch [releases for the repository](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/managing-subscriptions-for-activity-on-github/viewing-your-subscriptions#watching-releases-for-a-repository).

-------------

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website.

To integrate PomeloCards into your Xcode project using CocoaPods you just have to:

1. If you haven’t already, install the latest version of [Cocoapods](https://guides.cocoapods.org/using/getting-started.html).

2. Add our private spec repository to your CI/Local environment:

``` ruby
pod repo add pomelo-specs 'https://github.com/pomelo/Specs.git'
```

3. If you don’t have an existing Podfile, run the following command to create one:

``` ruby
pod init
```

4. Add our repo source at the top of your Podfile:

``` ruby
source 'https://github.com/pomelo/Specs.git'
```

5. Last, just add the dependency to your app’s target.

``` ruby
target 'MyApp' do
  pod 'PomeloCards', '~> 0.1.0'
end
```

6. Don’t forget to use the .xcworkspace file to open your project in Xcode, instead of the .xcodeproj file, from here on out.

> We recommend to use the opstimistic operator '~>' instead of not specify the version your going to use, to be sure that you are not going to update the version of our SDK to one that have a breaking change without testing it firts.

-------------

## 2. Register SDK into your Application

To initialize the SDK, first you have to setup the initial configuration on your `SceneDelegate`.

``` swift
let configuration = PomeloCardsConfiguration(environment: .development)

PomeloCards.initialize(with: configuration)
```

| Parameters  |  |
| ------------- | ------------- |
| **Environment**: enum | Indicates the environment, which can be `.development`, `staging` or `production`  |

You also have to setup the ```NSFaceIDUsageDescription``` parametter on your `Info.plist`. This is because we use the biometric prompt to be sure that the end users is actually the cardHolder.

Example: 

``` xml
<key>NSFaceIDUsageDescription</key>
<string>$(PRODUCT_NAME) uses Face ID to validate your identity</string>
```

<img width="806" alt="Screen Shot 2022-12-22 at 14 04 03" src="https://user-images.githubusercontent.com/100163572/209188133-32ed4a31-d67a-42fc-b3d6-7550f290b64f.png">

> You can use the message of your preference

-------------

## 3. Authorization

Any company involved with the processing, transmission, or storage of card data, incluiding the primary account number (PAN), expiration date, and card verification value (CVV), must comply with the Payment Card Industry Data Security Standard (PCI DSS). Achieving PCI DSS certification is both time consuming and expensive.

Pomelo is fully PCI-Service Provider compliant and handles the unencrypted sensitive card data for you. Your servers never store, transmit, or process the card data.

The following process describes how Pomelo components work using the authorization service layer provided by your application to ensure that your end users have their sensitive data in a securely way.

![DOCs - Guideline de Diseño _ UX](https://user-images.githubusercontent.com/100163572/209385673-c46aa780-f9f3-4123-a29c-c723512553b6.svg)

Because of that you have to configure an authorization service injecting an `AuthorizationService` that implements the protocol `PomeloAuthorizationServiceProtocol`. On it you have to implement the logic to generate an [end user token](https://github.com/pomelo-la/sdk-cards-backend-nodejs/blob/feature/documentation/docs/end-user-token.md) which is a short-lived JWT token that you have to provide to the SDK to be able to communicate with our secure data services.

>We reccomend to encapsulate the logic of the end user token request on your back end services and only make a fetch to that service in your iOS native implementation of the `AuthorizationService`.
For more information about the end user token, examples, and recomendations for backend implementation for it, please visit this [page](https://github.com/pomelo-la/sdk-cards-backend-nodejs/blob/feature/documentation/docs/end-user-integration.md).

Once you have your `AuthorizationService` fully developed you just have to configure it on your `SceneDelegate`:

``` swift
PomeloNetworkConfigurator.shared.configure(authorizationService: EndUserTokenAuthorizationService())
```

>Go to this [repo](https://github.com/pomelo-la/cards-ios-demo/blob/develop/PomeloCardsDemo/Auth/EndUserTokenResolver.swift) to see an example of an authorization service implemented on our demo app.

-------------

## Fully setup sample

 Having followed all the previous steps your `SceneDelegate`configuration must be like:

``` swift
import UIKit
import PomeloCards
import PomeloUI
import PomeloNetworking

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupPomeloCards()
    }

    private func setupPomeloCards() {
        //Configure Cards SDK
        PomeloCards.initialize(with: PomeloCardsConfiguration(environment: .develop))
        //Configure authorization service on PomeloNetworkConfigurator
        PomeloNetworkConfigurator.shared.configure(authorizationService: EndUserTokenAuthorizationService())
        //Configure theme on PomeloUI
        PomeloUIGateway.shared.configure(theme: YourTheme())
    }
}
```

See the [customizing section](#customizing) for more information about how to build your `YourTheme` to customize the UI copmponents.

-------------

## 4. Usage

To use the SDK components and methos all you have to do is to add the import and you are ready to go.

```swift
import PomeloCards

// Put your implementation here!
```

-------------

## Initializing Widgets

### Card

<img src="https://user-images.githubusercontent.com/9848247/206248330-032a478e-070e-4a2d-a0a3-fe661629be06.png"/><img src="https://user-images.githubusercontent.com/9848247/206260248-6773169e-ac56-4751-9a2d-1c5467b53e80.png"/>

Card image with sensitive data

``` swift
class PomeloCardWidgetView: UIView
```

#### Summary

##### Public function

###### init

``` swift
init(
    cardholderName: String, 
    lastFourCardDigits: String, 
    cardImage: UIImage?, 
    parentViewController: UIViewController? = nil
    )
```

Initialize the widget with its content.

| Parameters  |  |
| ------------- | ------------- |
| **cardholderName**: String | Card holder name. It will be shown as upper case. |
| **lastFourCardDigits**: String | The last four digits of the card to be shown  |
| **cardImage**: UIImage? | (Optional) The background card image. The background is clear by default. |
| **parentViewController**: UIVIewController? | (Optional) The parent view controller that contains the cardView. **If it is provided it will be used to display an alert with retry logic in case the service fails.** |

###### showSensitiveData

``` swift 
func showSensitiveData(
    cardId: String, 
    onPanCopy: (() -> Void)?, 
    completionHandler: @escaping (Result<Void, PomeloError>) -> Void
    )
```

Reveals the hidden sensitive data from the card after passing successfully a biometric prompt.

| Parameters  |  |
| ------------- | ------------- |
| **cardId**: String | The id of the card. Example _crd-ABCD1234_e |
| **onPanCopy**: (() -> Void)? | Callback called when the user copied the card PAN number to the Pasteboard. It can be used to show an alert on your app |
| **completionHandler**: @escaping (Result<Void, PomeloError>) -> Void | Callback called after Pomelo services request, it returns an error in case of fauilure, otherwise it succeded. |

-------------

### Card List Information

<img src="https://user-images.githubusercontent.com/9848247/206261361-bdb05969-9adb-4c00-ae41-7eb450b285fe.png"/>

List with sensitive data from the card.

``` swift
class PomeloCardWidgetDetailViewController
```

#### Summary

##### Public function

You can display the card informations as a **list** and embed in your view just using the ViewController initializer as follows:

``` swift
let widgetDetailViewController = PomeloCardWidgetDetailViewController()
```

Also can display the list as a bottomsheet using the extension `displayViewControllerAsBottomSheet` from your parent view controller:

``` swift
let widgetDetailViewController = PomeloCardWidgetDetailViewController()

yourParentViewController.displayViewControllerAsBottomSheet(widgetDetailViewController)
```

###### showSensitiveData

``` swift 
func showSensitiveData(
    cardId: String, 
    onPanCopy: (() -> Void)?, 
    completionHandler: @escaping (Result<Void, PomeloError>) -> Void
    )
```

Reveals the hidden sensitive data from the card after passing successfully a biometric prompt.

| Parameters  |  |
| ------------- | ------------- |
| **cardId**: String | The id of the card. Example _crd-ABCD1234_e |
| **onPanCopy**: (() -> Void)? | Callback called when the user copied the card PAN number to the Pasteboard. It can be used to show an alert on your app |
| **completionHandler**: @escaping (Result<Void, PomeloError>) -> Void | Callback called after Pomelo services request, it returns an error in case of fauilure, otherwise it succeded. |

-------------

### Activate Card

<img src="https://user-images.githubusercontent.com/9848247/206264844-631ed776-d10d-4aff-a91a-c6e194e67db2.png"/>

Activates a new card after completing the PAN and PIN.

#### Summary

##### Public function

###### init

``` swift
init(completionHandler: @escaping (Result<String?, PomeloError>) -> Void)
```

Initialize the widget with its content.

| Parameters  |  |
| ------------- | ------------- |
| **completionHandler**: @escaping (Result<String?, PomeloError>) -> Void | Callback called after the activation, it returns the **card id** if succeeded or an **error** in case of failure. |

-------------

### Change PIN

<img width=380 src="https://user-images.githubusercontent.com/9848247/206264696-8bc3f882-058f-478f-9ade-98e5ca9abb07.png"/>

Updates the PIN number.

#### Summary

##### Public function

###### init

``` swift
init(
    cardId: String, 
    completionHandler: @escaping (Result<Void, PomeloError>) -> Void
    )   
```

Initialize the widget with its content.

| Parameters  |  |
| ------------- | ------------- |
| **cardId**: String | The id of the card to activate |
| **completionHandler**: @escaping (Result<Void, PomeloError>) -> Void | Callback called after the change pin request, it returns an **error** in case of failure otherwise it succeded |

-------------

## Customizing

You can customize the appearance of the UI components by using the **PomeloTheme** object. This object allows you to change colors, button styles, fonts, feedback icons and cards background images.

We show you a custom PomeloTheme bellow:

``` swift
class YourTheme: PomeloThemeable {
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

```

With this theme your componets will looks like this card activation widget:

<img width=380 src="https://user-images.githubusercontent.com/100163572/209220914-bdfc164a-02c2-43d0-b5fb-946e3ddd76ba.png"/>

>**Dark mode**: Every component of the SDK supports darkmode, you only have to set UIColors that support thios feature to build your custom `PomeloTheme` and every component will change it's color when the device configuration change. 

For more information about how to use these component customization features you can go to [Pomelo UI iOS docs](https://github.com/pomelo-la/ui-ios#readme).

-------------

## Supported Languages

Now the SDK supports **Spanish**, **Portuguese** and **English** as preferred lanmguages. The user just have to select their preference language and the componebnts will show all the content in that language.
