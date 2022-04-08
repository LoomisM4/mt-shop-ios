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
    @State var items: [ShopLocation] = []
    
    var body: some View {
        Map(coordinateRegion: $controller.position, showsUserLocation: true, annotationItems: items) { item in
            MapMarker(coordinate: item.coordinates)
        }
            .onAppear {
                controller.onLocationUpdate = self.onLocationUpdate(long:lat:)
                controller.getPosition()
        }
    }
    
    func onLocationUpdate(long: CLLocationDegrees, lat: CLLocationDegrees) {
        let newLat = lat + 0.002
        let newLong = long - 0.003
        let coordinate = CLLocationCoordinate2D(latitude: newLat, longitude: newLong)
        items.append(ShopLocation(coordinates: coordinate))
    }
}

struct ShopLocation: Identifiable {
    var id = UUID()
    
    let coordinates: CLLocationCoordinate2D
}
