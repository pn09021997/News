//
//  DBManager.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit
import Firebase
import OSLog

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
        ref.child("YourNews/\(getIsLogin())").observeSingleEvent(of: .value){
            (snapshot) in let listNews = snapshot.value as? NSDictionary

            if let listNews = listNews {
                completion(.success(listNews))
            }
        }
    }
    
    func deleteFavorNews_Id(url: String) {
        var check: Bool = true
        DBManager.DB.getListFavorNew{ result in
            switch result {
            case .success(let listFavorNews):
                for (key, value) in listFavorNews {
                    let favorNews = value as? NSDictionary
                    let urlTxt = favorNews?.value(forKey: "url") as! String
                    if (url == urlTxt) {
                        check = false
                        self.articleID = key as! String
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    if (check == false) {
                        os_log("remove successfully")
                        self.ref.child("YourNews/\(self.getIsLogin())").child(self.articleID).removeValue()
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    
    func addFavorNews (article articleDetail: Article?) -> Bool{
        var check: Bool = true
        DBManager.DB.getListFavorNew{ result in
            switch result {
            case .success(let listFavorNews):
                for (key, value) in listFavorNews {
                    let favorNews = value as? NSDictionary
                    let urlTxt = favorNews?.value(forKey: "url") as! String
                    if (articleDetail?.url == urlTxt) {
                        check = false
                        self.articleID = key as! String
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    if (check == true) {
                        os_log("article valid for insert")
                        if let article = articleDetail{
                            let articlesArr = [
                                "title": article.title,
                                "description": article.description ?? "No Description",
                                "url": article.url,
                                "urlToImage": article.urlToImage ?? "default",
                                "publishedAt": article.publishedAt
                            ]
                            self.ref.child("YourNews/\(self.getIsLogin())").childByAutoId().setValue(articlesArr)
                        }
                    } else {
                        os_log("article invalid for insert")
                        os_log("remove successfully")
                        self.checkFavorNews = false
                        self.ref.child("YourNews/\(self.getIsLogin())").child(self.articleID).removeValue()
                    }
                }
            case .failure(_):
                break
            }
        }
        if (self.checkFavorNews == true) {
            return false
        } else {
            self.checkFavorNews = true
            return true
        }
    }
}
