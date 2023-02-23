//
//  PomeloCardsSwiftUIDemoApp.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 23/02/2023.
//

import SwiftUI

@main
struct PomeloCardsSwiftUIDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

