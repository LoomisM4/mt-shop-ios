//
//  ArticleList.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 21.03.22.
//

import SwiftUI

struct ArticleList: View { // 1
    @State var articles: [Article]? // 1
    
    var link: Link // 0
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2) // 6
    
    init(_ articlesUrl: Link) { // 1
        self.link = articlesUrl // 2
    }
    
    var body: some View { // 1
        ScrollView { // 1
            if let articles = articles { // 2
                LazyVGrid(columns: columns) { // 2
                    ForEach(articles, id: \.id) { article in // 4
                        if let url = article.links.preview { // 4
                            NavigationLink(destination: ArticleUI(article: article)) { // 4
                                CachedImage(url: url.href) { img in // 4
                                    return img.resizable().scaledToFit() // 3
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: loadArticles) // 2
    }
    
    private func loadArticles() { // 1
        Api.articles(articlesUrl: link) { response in // 3
            articles = response.embedded.articles // 3
        }
    }
}

// 45
