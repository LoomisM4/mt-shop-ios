//
//  mt_shop_iosApp.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

@main
struct mt_shop_iosApp: App {
    init() {
        NetworkChecker.startMonitoring() // 1
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// 1
