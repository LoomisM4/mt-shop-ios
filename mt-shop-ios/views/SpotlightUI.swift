//
//  Spotlight.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct SpotlightUI: View { // 1
    @State var articles: [Article] // 1
    
    init() { // 1
        articles = [] // 1
    }
    
    func loadArticlesInSpotlight() { // 1
        Api.spotlight { response in // 2
            articles = response.embedded.articles! // 3
        }
    }
    
    var body: some View { // 1
        ScrollView { // 1
            VStack { // 1
                ForEach(articles, id: \.id) { a in // 4
                    NavigationLink(destination: ArticleUI(article: a)) { // 4
                        let link = a.links.spotlightImage // 3
                        if let l = link { // 2
                            CachedImage(url: l.href) { img in // 4
                                return img.resizable().scaledToFit() // 3
                            }
                        } else { // 1
                            Image(systemName: "xmark.seal") // 2
                        }
                    }
                }
            }
        }.onAppear { // 1
            loadArticlesInSpotlight() // 1
        }
    }
}

struct Spotlight_Previews: PreviewProvider {
    static var previews: some View {
        SpotlightUI()
    }
}

// 38
