//
//  Map.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI
import MapKit

struct MapUI: View {
    @StateObject var controller = MapController()
    
    var body: some View {
        Map(coordinateRegion: $controller.position)
            .onAppear {
                controller.onLocationUpdate = self.onLocationUpdate(long:lat:)
                controller.getPosition()
        }
    }
    
    func onLocationUpdate(long: CLLocationDegrees, lat: CLLocationDegrees) {
        // TODO API Call
    }
}
