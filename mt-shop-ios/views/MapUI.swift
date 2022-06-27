//
//  Map.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI
import MapKit

struct MapUI: View { // 1
    @StateObject var controller = MapController() // 3
    @State var items: [ShopLocation] = [] // 2
    
    var body: some View { // 1
        Map(coordinateRegion: $controller.position, showsUserLocation: true, annotationItems: items) { item in
            MapMarker(coordinate: item.coordinates) // 9
        }
            .onAppear { // 1
                controller.onLocationUpdate = self.onLocationUpdate(long:lat:) // 3
                controller.getPosition() // 1
        }
    }
    
    func onLocationUpdate(long: CLLocationDegrees, lat: CLLocationDegrees) { // 1
        let newLat = lat + 0.002 // 2
        let newLong = long - 0.003 // 2
        let coordinate = CLLocationCoordinate2D(latitude: newLat, longitude: newLong) // 4
        items.append(ShopLocation(coordinates: coordinate)) // 3
    }
}

struct ShopLocation: Identifiable { // 1
    var id = UUID() // 2
    
    let coordinates: CLLocationCoordinate2D // 0
}

// 36
