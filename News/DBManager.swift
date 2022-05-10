//
//  DBManager.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit

class DBManager {
    static let DB = DBManager()
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
}
