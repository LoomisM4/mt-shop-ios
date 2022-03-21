//
//  Spotlight.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct SpotlightUI: View {
    @State var articles: [Article]
    
    init() {
        articles = []
    }
    
    func loadArticlesInSpotlight() {
        Api.spotlight { response in
            articles = response.embedded.articles!
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(articles, id: \.id) { a in
                    NavigationLink(destination: ArticleUI(article: a)) {
                        let link = a.links.spotlightImage
                        if let l = link {
                            CachedImage(url: l.href)
                        } else {
                            Image(systemName: "xmark.seal")
                        }
                    }
                }
            }
        }.onAppear {
            loadArticlesInSpotlight()
        }
    }
}

struct Spotlight_Previews: PreviewProvider {
    static var previews: some View {
        SpotlightUI()
    }
}
