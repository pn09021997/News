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
    
    /*//if else between 2 screen login and your opinion
    override func prepare(for: UIStoryboardSegue, sender: Any?) {
        
    }*/
    
    @IBAction func btnLogin(_ sender: Any) {
        if (!checkIsLogin) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            self.present(vc, animated: true, completion: nil)
        }

    }
}
