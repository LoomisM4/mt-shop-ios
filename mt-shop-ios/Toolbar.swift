//
//  Toolbar.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 11.03.22.
//

import SwiftUI

struct Toolbar: ToolbarContent {
    @State var searchFieldVisible: Bool = false
    @State var searchString: String = ""
    @State var searchButtonVisible: Bool
    @State var accountButtonVisible: Bool = true
    
    init(searchButtonVisible: Bool) {
        self.searchButtonVisible = searchButtonVisible
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if searchFieldVisible {
                Button(action: {
                    controllToolbarItems(isActive: false)
                }, label: {
                    Image(systemName: "x.circle")
                })
            }
        }
        ToolbarItem(placement: .primaryAction) {
            if searchFieldVisible {
                TextField("Test", text: $searchString)
                    .onSubmit {
                        NSLog("TODO Suche abgeschickt")
                    }
                    .frame(width: 1)
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            if searchButtonVisible {
                Button {
                    controllToolbarItems(isActive: true)
                } label: {
                    Image(systemName: "magnifyingglass")
                }

            }
        }
    }
    
    func controllToolbarItems(isActive: Bool) {
        searchFieldVisible = isActive
        searchButtonVisible = !isActive
        accountButtonVisible = !isActive
    }
}
