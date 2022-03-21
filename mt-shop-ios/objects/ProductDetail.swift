//
//  ProductDetail.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import Foundation
import SwiftUI

class ProductDetail {
    let id: Int
    let imageUrls: [String]
    let description: String
    
    init(id: Int, imageUrls: [String], description: String) {
        self.id = id
        self.imageUrls = imageUrls
        self.description = description
    }
}
