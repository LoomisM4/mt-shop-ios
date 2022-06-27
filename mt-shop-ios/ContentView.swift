//
//  ContentView.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct ContentView: View { // 1
    var body: some View { // 1
        TabView { // 1
            NavigationView { // 1
                SpotlightUI().navigationTitle("Spotlight") // 2
            }.tabItem{ // 1
                Image(systemName: "star") // 2
            }
            NavigationView { // 1
                CategoriesUI().navigationTitle("Kategorien") // 2
            }.tabItem { // 1
                Image(systemName: "list.dash") // 2
            }
            NavigationView { // 1
                CartUI().navigationTitle("Warenkorb") // 2
            }.tabItem { // 1
                Image(systemName: "cart") // 2
            }
            NavigationView { // 1
                MapUI().navigationTitle("Umgebung") // 2
            }.tabItem { // 1
                Image(systemName: "map") // 2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// 27
