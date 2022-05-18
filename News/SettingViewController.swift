//
//  SettingViewController.swift
//  News
//
//  Created by Nguyen Phuong on 12/02/1401 AP.
//

import UIKit

class SettingViewController: UIViewController {
    private var checkIsLogin = true
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Setting")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if (checkIsLogin) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnYourNews(_ sender: Any) {
        if (!checkIsLogin) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourNewsTableViewController") as! YourNewsTableViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotLoginViewController") as! NotLoginViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
}
