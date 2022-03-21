//
//  ContentView.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                SpotlightUI().navigationTitle("Spotlight")
            }.tabItem{
                Image(systemName: "star")
            }
            NavigationView {
                CategoriesUI().navigationTitle("Kategorien")
            }.tabItem {
                Image(systemName: "list.dash")
            }
            NavigationView {
                CartUI().navigationTitle("Warenkorb")
            }.tabItem {
                Image(systemName: "cart")
            }
            NavigationView {
                MapUI().navigationTitle("Umgebung")
            }.tabItem {
                Image(systemName: "map")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
