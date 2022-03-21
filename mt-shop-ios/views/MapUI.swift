//
//  Map.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI
import MapKit

struct MapUI: View {
    @StateObject var controller: MapController = MapController()
    
    var body: some View {
        Map(coordinateRegion: $controller.position)
    }
}

struct MapUI_Previews: PreviewProvider {
    static var previews: some View {
        MapUI()
    }
}
