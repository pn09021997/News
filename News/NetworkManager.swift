//
//  NetworkManager.swift
//  News
//
//  Created by Nguyen Phuong on 09/02/1401 AP.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    struct Constants {
        static let baseUrl = URL(string: "https://newsapi.org/v2/everything?q=technology&sortBy=publishedAt&apiKey=05e37a7f003b4e80bbbd3af9ae86eaf8")
        static let topHeadlinesUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=technology&sortBy=popularity&apiKey=05e37a7f003b4e80bbbd3af9ae86eaf8")
        static let searchUrl = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=05e37a7f003b4e80bbbd3af9ae86eaf8&q="
    }
    
    func downloadNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.baseUrl else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    func dowloadHeadlinesNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesUrl else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    //Dowload Search News with keyword
    func dowloadSearchNews(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchUrl + query
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
