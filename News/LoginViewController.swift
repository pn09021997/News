//
//  LoginViewController.swift
//  News
//
//  Created by Nguyen Phuong on 15/02/1401 AP.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        // create the alert
                let alert = UIAlertController(title: "Notice", message: "Lauching this missile will destroy the entire universe. Is this what you intended to do?", preferredStyle: UIAlertController.Style.alert)

                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Remind Me Tomorrow", style: UIAlertAction.Style.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Launch the Missile", style: UIAlertAction.Style.destructive, handler: nil))

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
