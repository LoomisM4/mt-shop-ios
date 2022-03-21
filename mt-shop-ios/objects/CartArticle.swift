//
//  CartProduct.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 10.03.22.
//

import Foundation

class CartArticle: ObservableObject, Identifiable {
    let articleDetails: Details
    @Published var quantity: Int
    @Published var positionPrice: Double?
    
    init(_ articleDetails: Details) {
        self.articleDetails = articleDetails
        self.quantity = 1
        self.calcPositionPrice()
    }
    
    func more() {
        quantity += 1
        calcPositionPrice()
    }
    
    func less() {
        if (quantity > 0) {
            quantity -= 1
            calcPositionPrice()
        }
    }
    
    func calcPositionPrice() {
        positionPrice = Double(quantity) * articleDetails.price
    }
}
