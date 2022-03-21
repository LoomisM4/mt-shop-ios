//
//  AsyncView.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 17.03.22.
//

import SwiftUI

struct CachedImage: View {
    @State var content: Image?
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        ZStack {
            if let content = content {
                content.resizable().scaledToFit()
            } else {
                ProgressView()
            }
        }.onAppear(perform: loadImage)
    }
    
    func loadImage() {
        Api.image(url: url) { img in
            self.content = Image(uiImage: img)
        }
    }
}
