//
//  Api.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 15.03.22.
//

import Foundation
import SwiftUI
import Network

class Api { // 1
    private static let base = "http://shop.marcelwettach.eu" // 1
    private static let cacheHandler = CacheHandler() // 2
    
    static func spotlight(onResonse: @escaping (Response) -> Void) { // 1
        let url = URL(string: base + "/spotlight") // 4
        callApi(url, completionHandler: onResonse) // 2
    }
    
    static func categories(subcategoriesUrl: Link?, onResponse: @escaping (Response) -> Void) { // 1
        var link = base + "/categories" // 2
        if let subs = subcategoriesUrl { // 2
            link = subs.href // 2
        }
        let url = URL(string: link) // 3
        callApi(url, completionHandler: onResponse) // 2
    }
    
    static func details(_ link: Link, onResponse: @escaping (Article) -> Void) { // 1
        callApi(URL(string: link.href), completionHandler: onResponse) // 5
    }
    
    static func articles(articlesUrl: Link, onResponse: @escaping (Response) -> Void) { // 1
        callApi(URL(string: articlesUrl.href), completionHandler: onResponse) // 5
    }
    
    static func image(url: String, content: @escaping (UIImage) -> Void) { // 1
        let request = URLRequest(url: URL(string: url)!) // 5
        if NetworkChecker.isOnline { // 2
            let task = URLSession.shared.dataTask(with: request) { data, response, error in // 7
                guard checkResponse(data: data, error: error) else { // 5
                    print("Es ist ein Fehler aufgetreten") // 0
                    return // 1
                }

                if let image = UIImage(data: data!) { // 4
                    cacheHandler.save(request, CachedURLResponse(response: response!, data: data!)) // 4
                    content(image) // 1
                }
            }
            task.resume() // 1
        } else { // 1
            if let response = cacheHandler.load(request) { // 3
                if let image = UIImage(data: response.data) { // 5
                    content(image) // 1
                }
            }
        }
    }
    
    static fileprivate func callApi<T: Codable>(_ url: URL?, completionHandler: @escaping (T) -> Void) { // 1
        let request = URLRequest(url: url!) // 3
        
        if NetworkChecker.isOnline { // 2
            let task = URLSession.shared.dataTask(with: request) { data, response, error in // 7
                guard checkResponse(data: data, error: error) else { // 5
                    print("Es ist ein Fehler aufgetreten") // 0
                    return // 1
                }
                
                do { // 1
                    let t = try JSONDecoder().decode(T.self, from: data!) // 5
                    // cache response
                    cacheHandler.save(request, CachedURLResponse(response: response!, data: data!)) // 4
                    
                    completionHandler(t) // 1
                } catch { // 1
                    print("Parsing not possible") // 0
                }
            }
            task.resume() // 1
        } else { // 1
            if let response = cacheHandler.load(request) { // 3
                do { // 1
                    let t = try JSONDecoder().decode(T.self, from: response.data) // 6
                    
                    completionHandler(t) // 1
                } catch { // 1
                    print("Parsing not possible") // 0
                }
            }
        }
    }
    
    static private func checkResponse(data: Data?, error: Error?) -> Bool { // 1
        if let error = error { // 2
            print(error.localizedDescription) // 0
            return false // 1
        }
        
        guard data != nil else { // 3
            return false // 1
        }

        return true // 1
    }
}

// 130
