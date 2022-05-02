//
//  NetworkManager.swift
//  News
//
//  Created by Nguyen Phuong on 09/02/1401 AP.
//

import Foundation


/*class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let USTopHeadline = "top-headlines?country=us"
    
    func getNews(completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseUrlString)\(USTopHeadline)&apiKey=05e37a7f003b4e80bbbd3af9ae86eaf8"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, reponsen, error) in guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let newsEvelope = try? JSONDecoder().decode(NewsEvelope.self, from: data)
            newsEvelope == nil ? completion(nil) : completion(newsEvelope!.articles)
        }.resume()
    }
    
    /*func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) {
                (data, reponsen, error) in guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(nil)
            }.resume()
        }
    }*/
}*/
