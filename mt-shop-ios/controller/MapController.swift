//
//  MapController.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 13.03.22.
//

import Foundation
import MapKit

class MapController: CLLocationManager, ObservableObject {
    var position: MKCoordinateRegion = MKCoordinateRegion()
    
    override init() {
        super.init()
        self.askForPermission()
    }
    
    private func askForPermission() {
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocation) {
        self.position = MKCoordinateRegion(center: manager.coordinate, span: MKCoordinateSpan())
    }
}
