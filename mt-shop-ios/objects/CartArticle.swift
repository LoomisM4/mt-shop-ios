//
//  CartProduct.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 10.03.22.
//

import Foundation

class CartArticle: ObservableObject, Identifiable { // 1
    let articleDetails: Article // 0
    @Published var quantity: Int // 1
    @Published var positionPrice: Double? // 1
    
    init(_ articleDetails: Article) { // 1
        self.articleDetails = articleDetails // 2
        self.quantity = 1 // 2
        self.calcPositionPrice() // 1
    }
    
    func more() { // 1
        quantity += 1 // 1
        calcPositionPrice() // 1
    }
    
    func less() { // 1
        if (quantity > 0) { // 2
            quantity -= 1 // 1
            calcPositionPrice() // 1
        }
    }
    
    func calcPositionPrice() { // 1
        positionPrice = Double(quantity) * (articleDetails.price ?? 0.0) // 5
    }
}

// 23
