//
//  RegisterViewController.swift
//  News
//
//  Created by Nguyen Phuong on 15/02/1401 AP.
//



struct AuthCatch{
    let checkValid: Bool
    let message: String
    
    init(checkValid: Bool, message: String) {
        self.checkValid = checkValid
        self.message = message
    }
}

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    private let ref = Database.database().reference()
    private var checkEmail: Bool?
    private var checkUserName: Bool?
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnRegister(_ sender: Any) {
        if let username = txtUsername.text?.replacingOccurrences(of: " ", with: ""),
           let password = txtPassword.text?.replacingOccurrences(of: " ", with: ""),
           let rePassword = txtRePassword.text?.replacingOccurrences(of: " ", with: ""),
           let email = txtEmail.text?.replacingOccurrences(of: " ", with: "") {
            if username.isEmpty || password.isEmpty || rePassword.isEmpty || email.isEmpty {
                showAlertMesssage(message: "Please fill out the form !!!")
            } else {
                if password == rePassword {
                    let validationCatch: [AuthCatch] = validation(password: password, email: email, username: username)
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
                            let newUser = User(username: username, password: password, email: email)
                            let newUserArr = [
                                "username": newUser.username,
                                "password": newUser.password,
                                "email": newUser.email
                            ]
                            ref.child("Users").childByAutoId().setValue(newUserArr)
                            self.showAlertMesssage(message: "Now you can login with this account")
                        }
                    }
                }
            }
        }
    }
    
    func showAlert2() {
        let alert = UIAlertController(title: "Notice", message: "Lauching this missile will destroy the entire universe. Is this what you intended to do?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Remind Me Tomorrow", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertMesssage(message: String) {
        // create the alert
        let alert = UIAlertController(title: "Errors", message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func validation(password: String, email: String, username: String) -> [AuthCatch]{
        var authCatch = [AuthCatch]()
        let specialCharacters = ["@", "#", "$", "%", "^"]
        if (password.count > 20 || password.count < 8) {
            authCatch.append(AuthCatch(checkValid: false, message: "The Lenght of password is not valid !!!"))
        }
        for (_, value) in specialCharacters.enumerated() {
            if ((password.firstIndex(of: Character(value))) != nil) || ((username.firstIndex(of: Character(value))) != nil) {
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
}
