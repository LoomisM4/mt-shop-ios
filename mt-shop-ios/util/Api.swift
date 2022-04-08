//
//  Api.swift
//  mt-shop-ios
//
//  Created by Marcel Wettach on 15.03.22.
//

import Foundation
import SwiftUI
import Network

class Api {
    private static let base = "http://shop.marcelwettach.eu"
    private static let cacheHandler = CacheHandler()
    
    static func spotlight(onResonse: @escaping (Response) -> Void) {
        let url = URL(string: base + "/spotlight")
        callApi(url, completionHandler: onResonse)
    }
    
    static func categories(subcategoriesUrl: Link?, onResponse: @escaping (Response) -> Void) {
        var link = base + "/categories"
        if let subs = subcategoriesUrl {
            link = subs.href
        }
        let url = URL(string: link)
        callApi(url, completionHandler: onResponse)
    }
    
    static func details(_ link: Link, onResponse: @escaping (Details) -> Void) {
        callApi(URL(string: link.href), completionHandler: onResponse)
    }
    
    static func articles(articlesUrl: Link, onResponse: @escaping (Response) -> Void) {
        callApi(URL(string: articlesUrl.href), completionHandler: onResponse)
    }
    
    static func image(url: String, content: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        if isOnline() {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard checkResponse(data: data, error: error) else {
                    print("Es ist ein Fehler aufgetreten")
                    return
                }

                if let image = UIImage(data: data!) {
                    cacheHandler.save(request, CachedURLResponse(response: response!, data: data!))
                    content(image)
                }
            }
            task.resume()
        } else {
            if let response = cacheHandler.load(request) {
                if let image = UIImage(data: response.data) {
                    content(image)
                }
            }
        }
    }
    
    static fileprivate func callApi<T: Codable>(_ url: URL?, completionHandler: @escaping (T) -> Void) {
        let request = URLRequest(url: url!)
        
        if isOnline() {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard checkResponse(data: data, error: error) else {
                    print("Es ist ein Fehler aufgetreten")
                    return
                }
                
                do {
                    let t = try JSONDecoder().decode(T.self, from: data!)
                    // cache response
                    cacheHandler.save(request, CachedURLResponse(response: response!, data: data!))
                    
                    completionHandler(t)
                } catch {
                    print("Parsing not possible")
                }
            }
            task.resume()
        } else {
            if let response = cacheHandler.load(request) {
                do {
                    let t = try JSONDecoder().decode(T.self, from: response.data)
                    
                    completionHandler(t)
                } catch {
                    print("Parsing not possible")
                }
            }
        }
    }
    
    static private func isOnline() -> Bool {
        let monitor = NWPathMonitor()
        let online = monitor.currentPath.status == .satisfied
        
        return online
    }
    
    static private func checkResponse(data: Data?, error: Error?) -> Bool {
        if let error = error {
            print(error.localizedDescription)
            return false
        }
        
        guard data != nil else {
            return false
        }

        return true
    }
}
