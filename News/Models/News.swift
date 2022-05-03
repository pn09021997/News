//
//  News.swift
//  News
//
//  Created by Nguyen Phuong on 09/02/1401 AP.
//

import UIKit

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
