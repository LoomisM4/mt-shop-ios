//
//  Links.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 15.03.22.
//

import Foundation

struct Links: Codable {
    let subcategories, spotlightImage, details, preview, articles: Link?
    let images: [Link]?
}
