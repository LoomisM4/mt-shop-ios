//
//  Details.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 15.03.22.
//

import Foundation

struct Details: Codable {
    let id: Int
    let name: String
    let price: Double
    let description: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, name, price, description
        case links = "_links"
    }
}
