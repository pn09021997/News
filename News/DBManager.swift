//
//  DBManager.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit
import Firebase

class DBManager {
    static let DB = DBManager()
    private let ref = Database.database().reference()
    private var checkFavorNews = true
    private var articleID = ""
    private var isLogin = true
    
    func getIsLogin () -> Bool {
        return self.isLogin
    }
    
    private init() {}
    
    func checkLogin() -> Bool {
        if (!isLogin) {
            return false
        }
        return true
    }
    
    func setisLogin () {
        if (true) {
            self.isLogin = true
        }
    }
    
    func getListFavorNew() {
        let userID = "-N1HpCU9jKvHNEzRPTrf"
        ref.child("YourNews/\(userID)").observeSingleEvent(of: .value){
            (snapshot) in let listNews = snapshot.value as? NSDictionary
             
            if let listNews = listNews {
                for (key, value) in listNews {
                    print("\(key): \(value)")
                }
            }
        }
    }
    
    func addFavorNews (article articleDetail: Article?) -> Bool {
        let userID = "-N1HpCU9jKvHNEzRPTrf"
        ref.child("YourNews/\(userID)").observeSingleEvent(of: .value){
            (snapshot) in let listNews = snapshot.value as? NSDictionary
             
            if let listNews = listNews {
                for (key, value) in listNews {
                    let favorNews = value as? NSDictionary
                    let urlTxt = favorNews?.value(forKey: "url") as! String
                    if (articleDetail?.url == urlTxt) {
                        self.articleID = key as! String
                        self.checkFavorNews = false
                    }
                }
            }
        }

        
        if (checkFavorNews == true) {
            if let article = articleDetail{
                let articlesArr = [
                    "title": article.title,
                    "description": article.description ?? "No Description",
                    "url": article.url,
                    "urlToImage": article.urlToImage ?? "default",
                    "publishedAt": article.publishedAt
                ]
                ref.child("YourNews/\(userID)").childByAutoId().setValue(articlesArr)
            }
            return true
        } else {
            print("We have it on DB")
            ref.child("YourNews/\(userID)").child(articleID).removeValue()
            self.checkFavorNews = true
            return false
        }
    }
}
