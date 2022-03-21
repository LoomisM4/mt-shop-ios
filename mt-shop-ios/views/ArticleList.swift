//
//  ArticleList.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 21.03.22.
//

import SwiftUI

struct ArticleList: View {
    @State var articles: [Article]?
    
    var link: Link
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    init(_ articlesUrl: Link) {
        self.link = articlesUrl
    }
    
    var body: some View {
        ScrollView {
            if let articles = articles {
                LazyVGrid(columns: columns) {
                    ForEach(articles, id: \.id) { article in
                        if let url = article.links.preview {
                            NavigationLink(destination: ArticleUI(article: article)) {
                                CachedImage(url: url.href) { img in
                                    return img.resizable().scaledToFit()
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: loadArticles)
    }
    
    private func loadArticles() {
        Api.articles(articlesUrl: link) { response in
            articles = response.embedded.articles
        }
    }
}
