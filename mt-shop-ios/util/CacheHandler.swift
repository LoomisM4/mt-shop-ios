//
//  CacheHandler.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 17.03.22.
//

import Foundation
import SwiftUI

class CacheHandler {
    let cache = URLCache()
    
    func load(_ request: URLRequest) -> CachedURLResponse? {
        return cache.cachedResponse(for: request)
    }
    
    func save(_ request: URLRequest, _ response: CachedURLResponse) {
        cache.storeCachedResponse(response, for: request)
    }
}
