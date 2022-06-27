//
//  AsyncView.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 17.03.22.
//

import SwiftUI

struct CachedImage<Content>: View where Content : View { // 1
    @State var content: Image? // 1
    
    var url: String // 0
    let style: (_ img: Image) -> Content // 0
    
    init(url: String, style: @escaping (Image) -> Content) { // 1
        self.url = url // 2
        self.style = style // 2
    }
    
    var body: some View { // 1
        ZStack { // 1
            if let content = content { // 2
                style(content) // 1
            } else { // 1
                ProgressView() // 1
            }
        }.onAppear(perform: loadImage) // 2
    }
    
    func loadImage() { // 1
        Api.image(url: url) { img in // 3
            self.content = Image(uiImage: img) // 4
        }
    }
}

// 24
