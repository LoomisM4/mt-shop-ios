//
//  Cart.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 12.03.22.
//

import Foundation

class Cart: ObservableObject {
    private static let cart = Cart()
    
    @Published var articles: [CartArticle] = []
    @Published var totalPrice: Double?
    
    private init() {}
    
    static func get() -> Cart {
        return Cart.cart
    }
    
    func addArticle(articleDetails: Details) {
        let savedArticle = articles.first { ca in
            ca.articleDetails.id == articleDetails.id
        }
        
        if let savedArticle = savedArticle {
            savedArticle.more()
        } else {
            articles.append(CartArticle(articleDetails))
        }
        
        self.calcTotalPrice()
    }
    
    func reduceArticle(articleDetails: Details) {
        let savedArticle = articles.first { ca in
            ca.articleDetails.id == articleDetails.id
        }
        
        guard let savedArticle = savedArticle else {
            print("Something went wrong")
            return
        }
        
        savedArticle.less()
        
        self.calcTotalPrice()
    }
    
    func clear() {
        articles = []
        totalPrice = nil
    }
    
    private func calcTotalPrice() {
        totalPrice = articles.reduce(0.0) { sum, a in
            sum + (a.positionPrice ?? 0.0)
        }
    }
}
