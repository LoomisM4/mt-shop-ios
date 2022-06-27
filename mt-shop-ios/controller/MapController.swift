//
//  MapController.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 13.03.22.
//

import Foundation
import CoreLocation
import MapKit

class MapController: NSObject, ObservableObject, CLLocationManagerDelegate { // 1
    let locationManager = CLLocationManager() // 2
    
    var onLocationUpdate: ((_ long: CLLocationDegrees, _ lat: CLLocationDegrees) -> Void)? // 1
    
    @Published var position = MKCoordinateRegion() // 3
    
    override init() { // 1
        super.init() // 1
        locationManager.delegate = self // 2
        locationManager.requestWhenInUseAuthorization() // 1
    }
    
    func getPosition() { // 1
        locationManager.startUpdatingLocation() // 1
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // 1
        locationManager.stopUpdatingLocation() // 1
        let coordinates = locations.first?.coordinate // 3
        if let coordinates = coordinates { // 2
            position = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.01), longitudeDelta: CLLocationDegrees(0.01))) // 9
            if let onLocationUpdate = onLocationUpdate { // 2
                onLocationUpdate(coordinates.longitude, coordinates.latitude) // 3
            }
        }
    }
}

// 35
