//
//  CacheHandler.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 17.03.22.
//

import Foundation
import SwiftUI

class CacheHandler { // 1
    let cache = URLCache() // 2
    
    func load(_ request: URLRequest) -> CachedURLResponse? { // 1
        return cache.cachedResponse(for: request) // 3
    }
    
    func save(_ request: URLRequest, _ response: CachedURLResponse) { // 1
        cache.storeCachedResponse(response, for: request) // 2
    }
}

// 10
