//
//  NetworkChecker.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 14.06.22.
//

import Network

class NetworkChecker { // 1
    static var isOnline = false; // 1
    
    static func startMonitoring() { // 1
        let monitor = NWPathMonitor() // 2
        let queue = DispatchQueue(label: "NetworkMonitor") // 3
        monitor.pathUpdateHandler = { handler in // 3
            if handler.status == .satisfied { // 4
                isOnline = true // 1
            } else { // 1
                isOnline = false // 1
            }
        }
        monitor.start(queue: queue) // 2
    }
}

// 20
