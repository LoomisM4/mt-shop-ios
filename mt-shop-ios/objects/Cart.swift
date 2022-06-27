//
//  Cart.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 12.03.22.
//

import Foundation

class Cart: ObservableObject { // 1
    private static let cart = Cart() // 2
    
    @Published var articles: [CartArticle] = [] // 2
    @Published var totalPrice: Double? // 1
    
    private init() {} // 1
    
    static func get() -> Cart { // 1
        return Cart.cart // 2
    }
    
    func addArticle(articleDetails: Article) { // 1
        let savedArticle = articles.first { ca in // 3
            ca.articleDetails.id == articleDetails.id // 4
        }
        
        if let savedArticle = savedArticle { // 2
            savedArticle.more() // 1
        } else { // 1
            articles.append(CartArticle(articleDetails)) // 2
        }
        
        self.calcTotalPrice() // 1
    }
    
    func reduceArticle(articleDetails: Article) { // 1
        let savedArticle = articles.first { ca in // 3
            ca.articleDetails.id == articleDetails.id // 4
        }
        
        if let savedArticle = savedArticle { // 2
            savedArticle.less() // 1
        }
        
        self.calcTotalPrice() // 1
    }
    
    func clear() { // 1
        articles = [] // 1
        totalPrice = nil // 1
    }
    
    private func calcTotalPrice() { // 1
        totalPrice = articles.reduce(0.0) { sum, a in // 4
            sum + (a.positionPrice ?? 0.0) // 3
        }
    }
}

// 48
