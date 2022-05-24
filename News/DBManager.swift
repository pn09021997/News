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
    private var isLogin = false
    private var userID: String?
    var viewModels = [YourNewsTableViewCellModel]()
    
    private init() {}
    
    func getIsLogin () -> String {
        if let returnValue = UserDefaults.standard.string(forKey: "USER_SESSION") {
            self.userID = returnValue
            self.isLogin = true
        }
        return self.userID!
    }
    
    func checkLogin() -> Bool {
        if let returnValue = UserDefaults.standard.string(forKey: "USER_SESSION") {
            self.userID = returnValue
            self.isLogin = true
        }
        print(self.isLogin)
        return self.isLogin
    }
    
    func logout () {
        UserDefaults.standard.removeObject(forKey: "USER_SESSION")
        self.isLogin = false
    }
    
    func getLoginInfo (userId: String, completion: @escaping (Result<NSDictionary, Error>) -> Void) {
        ref.child("Users/\(userId)").observeSingleEvent(of: .value){
            (snapshot) in let userInfo = snapshot.value as? NSDictionary

            if let userInfo = userInfo {
                completion(.success(userInfo))
            }
        }
    }
    
    func setisLogin (userId: String) {
        UserDefaults.standard.set(userId, forKey: "USER_SESSION")
        if let returnValue = UserDefaults.standard.string(forKey: "USER_SESSION") {
            self.userID = returnValue
            self.isLogin = true
        }
    }
    
    func getLoginList (completion: @escaping (Result<NSDictionary, Error>) -> Void) {
        ref.child("Users").observeSingleEvent(of: .value){
            (snapshot) in let listUsers = snapshot.value as? NSDictionary

            if let listUsers = listUsers {
                completion(.success(listUsers))
            }
        }
    }
    
    func getListFavorNew (completion: @escaping (Result<NSDictionary, Error>) -> Void){
        ref.child("YourNews/\(self.userID)").observeSingleEvent(of: .value){
            (snapshot) in let listNews = snapshot.value as? NSDictionary

            if let listNews = listNews {
                completion(.success(listNews))
            }
        }
    }
    
    func addFavorNews (article articleDetail: Article?) -> Bool {
        ref.child("YourNews/\(self.userID)").observeSingleEvent(of: .value){
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
                ref.child("YourNews/\(self.userID)").childByAutoId().setValue(articlesArr)
            }
            return true
        } else {
            print("We have it on DB")
            ref.child("YourNews/\(self.userID)").child(articleID).removeValue()
            self.checkFavorNews = true
            return false
        }
    }
}
