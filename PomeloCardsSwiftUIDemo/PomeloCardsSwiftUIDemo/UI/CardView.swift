//
//  CardView.swift
//  PomeloCardsSwiftUIDemo
//
//  Created by Fernando Pena on 24/02/2023.
//

import SwiftUI
import PomeloCards

struct CardView: View {
    let cardholder: String
    let lastFourDigits: String
    let imageFetcher: PomeloUIImageFetchable
    let cardId: String
    let onPanCopy: (() -> Void)?
    let completionHandler: (Result<Void, PomeloError>) -> Void
    @State var loadSensitiveData: Bool = false

    var body: some View {
        VStack {
            PomeloCardView(
                cardholder: cardholder,
                lastFourDigits: lastFourDigits,
                imageFetcher: imageFetcher,
                cardId: cardId,
                onPanCopy: onPanCopy,
                completionHandler: completionHandler, loadSensitiveData: $loadSensitiveData)
            Button {
                loadSensitiveData = true
            } label: {
                Text("Mostrar Datos")
            }

        }
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    @State var loadSensitiveData: Bool

    static var previews: some View {
        CardView(cardholder: "Juan Perez",
                 lastFourDigits: "3636",
                 imageFetcher: PomeloImageFetcher(image: UIImage(named: "TarjetaVirtual")!),
                 cardId: "",
                 onPanCopy: {},
                 completionHandler: { _ in })
    }
}
