//
//  InfoViewController.swift
//  News
//
//  Created by Nguyen Phuong on 21/02/1401 AP.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {
    private let ref = Database.database().reference()
    private var checkEmail: Bool?
    private var checkUserName: Bool?
    private var oldUserData: User?
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getLoginInfo()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogout(_ sender: Any) {
       showAlertAndLogout(message: "Would you like to logout ?", cancelCase: false)
    }
    
    func showAlertAndLogout(message: String, cancelCase: Bool) {
        // create the alert
        let alert = UIAlertController(title: "UIAlertController", message: message, preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
            switch action.style{
                case .default:
                DBManager.DB.logout()
                self.dismiss(animated: true, completion: nil)
                
                case .cancel:
                break
                
                
                case .destructive:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            if cancelCase {
                self.dismiss(animated: true, completion: nil)
            }
        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func getLoginInfo () {
        DBManager.DB.getLoginInfo(userId: DBManager.DB.getIsLogin()){ [weak self] result in
            switch result {
            case .success(let userInfo):
                if let email = userInfo.value(forKey: "email") as? String,
                   let password = userInfo.value(forKey: "password") as? String,
                   let username = userInfo.value(forKey: "username") as? String {
                    self?.txtUsername.text = username
                    self?.txtPassword.text = password
                    self?.txtEmail.text = email
                    self?.oldUserData = User(username: username, password: password, email: email)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func btnUpdateInfo(_ sender: Any) {
        if let email = self.txtEmail.text,
           let username = self.txtUsername.text,
           let password = self.txtPassword.text {
            if (email == oldUserData?.email) && (username == oldUserData?.username) {
                showAlertMesssage(message: "Nothing has changed !!!")
            } else  {
                if let username = txtUsername.text?.replacingOccurrences(of: " ", with: ""),
                   let email = txtEmail.text?.replacingOccurrences(of: " ", with: "") {
                    if username.isEmpty || email.isEmpty {
                        showAlertMesssage(message: "Please fill out the form !!!")
                    } else {
                        let validationCatch: [AuthCatch] = validation(email: email, username: username)
                        if (validationCatch.count != 0) {
                            var messageTxt = ""
                            for (_, value) in validationCatch.enumerated() {
                                messageTxt += "\(value.message)\n"
                            }
                            showAlertMesssage(message: messageTxt)
                        } else {
                            ref.child("Users").observeSingleEvent(of: .value){
                                (snapshot) in let listUser = snapshot.value as? NSDictionary
                                if let listUser = listUser {
                                    for (_, value) in listUser {
                                        let userInfo = value as? NSDictionary
                                        if let txtEmail = userInfo?.value(forKey: "email"),
                                           let txtUsername = userInfo?.value(forKey: "username") {
                                            self.checkUserName = username == (txtUsername as! String)
                                            self.checkEmail = email == (txtEmail as! String)
                                            if (self.checkEmail == true) || (self.checkUserName == true) {
                                                self.showAlertMesssage(message: "Your username / email already have !!!")
                                                break
                                            }
                                        }
                                    }
                                }
                            }
                            if self.checkEmail == false {
                                // create the alert
                                let alert = UIAlertController(title: "UIAlertController", message: "Would you like changed account info ?", preferredStyle: UIAlertController.Style.alert)

                                // add the actions (buttons)
                                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                                    switch action.style{
                                        case .default:
                                        let newUser = User(username: username, password: password, email: email)
                                        let newUserArr = [
                                            "username": newUser.username,
                                            "password": newUser.password,
                                            "email": newUser.email
                                        ]
                                        let userRef = self.ref.child("Users").child(DBManager.DB.getIsLogin())
                                        userRef.updateChildValues(newUserArr)
                                        self.showAlertAndLogout(message: "Your account updated successfully. Would you like to logout and re-login ?", cancelCase: true)
                                        
                                        case .cancel:
                                        break
                                        
                                        case .destructive:
                                        break
                                    }
                                }))
                                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                                // show the alert
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func validation(email: String, username: String) -> [AuthCatch]{
        var authCatch = [AuthCatch]()
        let specialCharacters = ["@", "#", "$", "%", "^"]
        for (_, value) in specialCharacters.enumerated() {
            if ((username.firstIndex(of: Character(value))) != nil) {
                authCatch.append(AuthCatch(checkValid: false, message: "Error to have special character !!!"))
                break
            }
        }
        if (email.firstIndex(of: "@") == nil) {
            authCatch.append(AuthCatch(checkValid: false, message: "Email is not valid !!!"))
        }
        if (username.count > 30 || username.count < 8) {
            authCatch.append(AuthCatch(checkValid: false, message: "The Lenght of username is not valid !!!"))
        }
        return authCatch
    }
    
    func showAlertMesssage(message: String) {
       
        // create the alert
        let alert = UIAlertController(title: "My Title", message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
