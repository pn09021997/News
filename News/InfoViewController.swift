//
//  InfoViewController.swift
//  News
//
//  Created by Nguyen Phuong on 21/02/1401 AP.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogout(_ sender: Any) {
        DBManager.DB.logout()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnUpdateInfo(_ sender: Any) {
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
