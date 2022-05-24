//
//  User.swift
//  News
//
//  Created by Nguyen Phuong on 26/02/1401 AP.
//

import UIKit

struct User {
    let username: String
    let password: String
    let email: String
    
    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
    }
}

struct AuthCatch{
    let checkValid: Bool
    let message: String
    
    init(checkValid: Bool, message: String) {
        self.checkValid = checkValid
        self.message = message
    }
}
