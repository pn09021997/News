//
//  LoginViewController.swift
//  News
//
//  Created by Nguyen Phuong on 15/02/1401 AP.
//

import UIKit

class LoginViewController: UIViewController {
    private var checkValidUsername: Bool?
    private var checkValidPassword: Bool?
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if let username = txtUsername.text?.replacingOccurrences(of: " ", with: ""),
           let password = txtPassword.text?.replacingOccurrences(of: " ", with: ""){
            if username.isEmpty || password.isEmpty {
                showAlertMesssage(message: "Please fill out the form !!!", errors: true)
            } else {
                let userTxt = User(username: username, password: password, email: "none")
                DBManager.DB.getLoginList{ [weak self] result in
                    switch result {
                    case .success(let loginList):
                        for (key, value) in loginList {
                            if let userInfo = value as? NSDictionary {
                                if let txtUsername = userInfo.value(forKey: "username"),
                                   let txtPassword = userInfo.value(forKey: "password") {
                                    
                                    self?.checkValidUsername = userTxt.username == (txtUsername as! String)
                                    self?.checkValidPassword = userTxt.password == (txtPassword as! String)
                                    if (self?.checkValidUsername == true) && (self?.checkValidPassword == true) {
                                        self?.showAlertMesssage(message: "Welcome back \(txtUsername)", errors: false)
                                        DBManager.DB.setisLogin(userId: (key as! String))
                                        break
                                    }
                                }
                            }
                        }
                        self?.showAlertMesssage(message: "Your username / password unvalid !!!", errors: true)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func showAlertMesssage(message: String, errors :Bool) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                if !errors {
                    self.dismiss(animated: true, completion: nil)
                }
                break
                
                case .cancel:
                break
                
                case .destructive:
                break
                
            }
        }))
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
