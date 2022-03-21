//
//  AsyncView.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 17.03.22.
//

import SwiftUI

struct CachedImage<Content>: View where Content : View {
    @State var content: Image?
    
    var url: String
    let style: (_ img: Image) -> Content
    
    init(url: String, style: @escaping (Image) -> Content) {
        self.url = url
        self.style = style
    }
    
    var body: some View {
        ZStack {
            if let content = content {
                style(content)
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
