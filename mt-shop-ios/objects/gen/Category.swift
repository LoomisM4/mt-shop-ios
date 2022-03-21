//
//  Category.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 15.03.22.
//

import Foundation

struct Category: Codable {
    
    let categoryID: Int
    let name: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name
        case links = "_links"
    }
}
