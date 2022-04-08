//
//  MapController.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 13.03.22.
//

import Foundation
import CoreLocation
import MapKit

class MapController: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    var onLocationUpdate: ((_ long: CLLocationDegrees, _ lat: CLLocationDegrees) -> Void)?
    
    @Published var position = MKCoordinateRegion()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getPosition() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let coordinates = locations.first?.coordinate
        if let coordinates = coordinates {
            position = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.01), longitudeDelta: CLLocationDegrees(0.01)))
            if let onLocationUpdate = onLocationUpdate {
                onLocationUpdate(coordinates.longitude, coordinates.latitude)
            }
        }
    }
}
