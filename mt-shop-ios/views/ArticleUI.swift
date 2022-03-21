//
//  Product.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct ArticleUI: View {
    @State var details: Details?
    
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    func loadArticleDetails() {
        Api.details(article.links.details!) { details in
            self.details = details
        }
    }
    
    var body: some View {
        VStack {
            if let details = details {
                ScrollView {
                    ScrollView(.horizontal) {
                        HStack {
                            let links = details.links.images
                            if let links = links {
                                ForEach(links, id: \.id) { l in
                                    CachedImage(url: l.href)
                                }
                            }
                        }
                    }
                    Spacer()
                    Button("In den Warenkorb") {
                        Cart.get().addArticle(articleDetails: details)
                    }
                    Spacer()
                    Text(details.description)
                }
            } else {
                Text("Lade")
            }
        }.onAppear {
            loadArticleDetails()
        }
    }
}

struct ImageView: View {
    let link: Link
    
    var body: some View {
        AsyncImage(url: URL(string: link.href), content: { img in
            img.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
        }) {
            ProgressView()
        }
    }
}
