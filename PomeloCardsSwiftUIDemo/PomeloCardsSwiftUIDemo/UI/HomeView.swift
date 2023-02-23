//
//  ContentView.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 23/02/2023.
//

import SwiftUI

struct HomeView: View {
    let factory: WidgetSwiftUIFactoryProtocol = WidgetSwiftUIFactory()
    
    var body: some View {
        NavigationView {
            List (WidgetType.allCases) { widget in
                NavigationLink {
                    factory.buildWidgetController(for: widget, params: widget.getParams())
                } label: {
                    Text(widget.getTitle())
                }
            }
        }
        .navigationTitle("Widgets")

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
