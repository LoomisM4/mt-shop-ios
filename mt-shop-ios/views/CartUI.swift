//
//  Cart.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct CartUI: View { // 1
    @StateObject var cart: Cart = Cart.get() // 3
    @State var showAlert = false // 2
    
    var body: some View { // 1
        VStack { // 1
            if (cart.articles.isEmpty) { // 3
                Text("Der Warenkorb ist leer") // 1
            } else { // 1
                List(cart.articles, id: \.id) { cartArticle in // 5
                    HStack { // 1
                        Text(cartArticle.articleDetails.name ?? "") // 4
                        Spacer() // 1
                        Button { // 1
                            cart.reduceArticle(articleDetails: cartArticle.articleDetails) // 3
                        } label: { // 1
                            Image(systemName: "minus.circle") // 2
                        }.buttonStyle(PlainButtonStyle()) // 2
                        Text("\(cartArticle.quantity)") // 2
                        Button { // 1
                            cart.addArticle(articleDetails: cartArticle.articleDetails) // 3
                        } label: { // 1
                            Image(systemName: "plus.circle") // 2
                        }.buttonStyle(PlainButtonStyle()) // 2
                        Spacer() // 1
                        Text((cartArticle.positionPrice ?? 0.0).description) // 4
                    }
                }
                Text("Preis: " + (cart.totalPrice ?? 0.00).description) // 5
                Button("Bezahlen") { // 1
                    showAlert = true // 1
                    cart.clear() // 1
                }
            }
        }.alert(isPresented: $showAlert) { // 2
            Alert(title: Text("Erfolg"), message: Text("Die Bestellung wurde abgeschickt")) // 5
        }
    }
}

struct CartUI_Previews: PreviewProvider {
    static var previews: some View {
        CartUI()
    }
}

// 64
