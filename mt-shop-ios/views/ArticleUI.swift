//
//  Product.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct ArticleUI: View { // 1
    @State var details: Article? // 1
    
    var article: Article // 0
    
    init(article: Article) { // 1
        self.article = article // 2
    }
    
    func loadArticleDetails() { // 1
        Api.details(article.links.details!) { details in // 4
            self.details = details // 2
        }
    }
    
    var body: some View { // 1
        VStack { // 1
            if let details = details { // 2
                ScrollView { // 1
                    ScrollView(.horizontal) { // 2
                        HStack { // 1
                            let links = details.links.images // 3
                            if let links = links { // 2
                                ForEach(links, id: \.id) { l in // 4
                                    CachedImage(url: l.href, style: { img in // 5
                                        return img.resizable() // 2
                                            .aspectRatio(contentMode: .fill) // 3
                                            .frame(width: UIScreen.main.bounds.width) // 5
                                    })
                                }
                            }
                        }
                    }
                    Spacer() // 1
                    Button("In den Warenkorb") { // 1
                        Cart.get().addArticle(articleDetails: details) // 3
                    }
                    Spacer() // 1
                    Text(details.name ?? "").fontWeight(.heavy) // 5
                    Spacer() // 1
                    Text(details.description ?? "") // 3
                }
            } else { // 1
                Text("Lade") // 1
            }
        }.onAppear { // 1
            loadArticleDetails() // 1
        }
    }
}

// 63
