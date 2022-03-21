//
//  Cart.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct CartUI: View {
    @StateObject var cart: Cart = Cart.get()
    @State var showAlert = false
    
    var body: some View {
        VStack {
            if (cart.articles.isEmpty) {
                Text("Der Warenkorb ist leer")
            } else {
                List(cart.articles, id: \.id) { cartArticle in
                    HStack {
                        Text(cartArticle.articleDetails.name)
                        Spacer()
                        Button {
                            cart.reduceArticle(articleDetails: cartArticle.articleDetails)
                        } label: {
                            Image(systemName: "minus.circle")
                        }.buttonStyle(PlainButtonStyle())
                        Text("\(cartArticle.quantity)")
                        Button {
                            cart.addArticle(articleDetails: cartArticle.articleDetails)
                        } label: {
                            Image(systemName: "plus.circle")
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                        Text((cartArticle.positionPrice ?? 0.0).description)
                    }
                }
                Text("Preis: " + (cart.totalPrice ?? 0.00).description)
                Button("Bezahlen") {
                    showAlert = true
                    cart.clear()
                }
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Erfolg"), message: Text("Die Bestellung wurde abgeschickt"))
        }
    }
}

struct CartUI_Previews: PreviewProvider {
    static var previews: some View {
        CartUI()
    }
}
