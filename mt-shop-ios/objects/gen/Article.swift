//
//  Article.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 12.03.22.
//

import Foundation

struct Article: Codable {
    let id: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case links = "_links"
    }
}
