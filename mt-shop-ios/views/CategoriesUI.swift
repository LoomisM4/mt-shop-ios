//
//  Categories.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 07.03.22.
//

import SwiftUI

struct CategoriesUI: View {
    var body: some View {
        CategoriesList(nil)
    }
}

struct CategoriesList: View {
    @State var categories: [Category] = []
    
    var subcategories: Link?
    
    init(_ subcategories: Link?) {
        self.subcategories = subcategories
    }
    
    func loadCategories() {
        Api.categories(subcategoriesUrl: subcategories) { response in
            categories = response.embedded.categories!
        }
    }
    
    var body: some View {
        List(categories, id: \.categoryID) { c in
            if let subs = c.links.subcategories {
                NavigationLink(c.name, destination: CategoriesList(subs).navigationTitle(c.name))
            } else {
                if let articlesUrl = c.links.articles {
                    NavigationLink(c.name, destination: ArticleList(articlesUrl).navigationTitle(c.name))
                }
            }
        }.onAppear {
            loadCategories()
        }
    }
}

struct CategoriesUI_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesUI()
    }
}
