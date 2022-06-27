//
//  Categories.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct CategoriesUI: View { // 1
    var body: some View { // 1
        CategoriesList(nil) // 1
    }
}

struct CategoriesList: View { // 1
    @State var categories: [Category] = [] // 2
    
    var subcategories: Link? // 0
    
    init(_ subcategories: Link?) { // 1
        self.subcategories = subcategories // 2
    }
    
    func loadCategories() { // 1
        Api.categories(subcategoriesUrl: subcategories) { response in // 3
            categories = response.embedded.categories! // 3
        }
    }
    
    var body: some View { // 1
        List(categories, id: \.categoryID) { c in // 4
            if let subs = c.links.subcategories { // 4
                NavigationLink(c.name, destination: CategoriesList(subs).navigationTitle(c.name)) // 6
            } else { // 1
                if let articlesUrl = c.links.articles { // 4
                    NavigationLink(c.name, destination: ArticleList(articlesUrl).navigationTitle(c.name)) // 6
                }
            }
        }.onAppear { // 1
            loadCategories() // 1
        }
    }
}

struct CategoriesUI_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesUI()
    }
}

// 45
