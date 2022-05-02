//
//  News.swift
//  News
//
//  Created by Nguyen Phuong on 09/02/1401 AP.
//

import UIKit

class News {
    private let title: String?
    private let description: String?
    private let urlToImage: UIImage?
    private let publishedAt: String
    private let category: String
    
    init?(title: String?, description: String?, urlToImage: UIImage?, publishedAt: String, category: String) {
        (!title!.isEmpty) ? (self.title = title) : (self.title = "unknow")
        (!description!.isEmpty) ? (self.description = description) : (self.description = "unknow")
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.category = category
    }
    
    public func getTitle() -> String { return self.title! }
    public func getDesc() -> String { return self.description! }
    public func getPublishedAt() -> String { return self.publishedAt }
    public func getCategory() -> String { return self.category }
    public func getUrlToImage() -> UIImage { return self.urlToImage! }
}

/*struct News: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}*/

/*struct NewsEvelope: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}*/



