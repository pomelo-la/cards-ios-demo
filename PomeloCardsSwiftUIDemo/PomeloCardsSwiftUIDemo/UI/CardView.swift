//
//  CardView.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 24/02/2023.
//

import SwiftUI
import PomeloCards

struct CardContainerView: View {
    @State var loadSensitiveData: Bool = false
    var cardViewBuilder: (Binding<Bool>) -> PomeloCardView

    init(@ViewBuilder builder: @escaping (Binding<Bool>) -> PomeloCardView) {
        self.cardViewBuilder = builder
    }

    var body: some View {
        VStack {
            cardViewBuilder($loadSensitiveData)
            Button {
                loadSensitiveData = true
            } label: {
                Text("Mostrar Datos")
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardContainerView { loadData in
            PomeloCardView(cardholder: "Juan Perez",
                           lastFourDigits: "3636",
                           imageFetcher: PomeloImageFetcher(image: UIImage(named: "TarjetaVirtual")!),
                           cardId: "",
                           onPanCopy: {},
                           completionHandler: { _ in },
                           loadSensitiveData: loadData)
        }
    }
}
