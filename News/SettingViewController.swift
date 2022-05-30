//
//  SettingViewController.swift
//  News
//
//  Created by Nguyen Phuong on 12/02/1401 AP.
//

import UIKit
import SafariServices

class SettingViewController: UIViewController {
    @IBOutlet weak var txtComplaint: UILabel!
    @IBOutlet weak var btnLoginRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.tapFunction))
        txtComplaint.isUserInteractionEnabled = true
        txtComplaint.addGestureRecognizer(tap)
        
        //Make a Link
        let attributedString = NSMutableAttributedString(string: "Complaint for TechNews App !", attributes: nil)
        let linkRange = NSMakeRange(14, 13);

        let linkAttributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue as AnyObject,
            NSAttributedString.Key.link: "https://forms.gle/Av422ZpKcS3x4ZRA8" as AnyObject ]
        attributedString.setAttributes(linkAttributes, range:linkRange)

        txtComplaint.attributedText = attributedString
    
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let url = URL(string: "https://forms.gle/Av422ZpKcS3x4ZRA8") else {
            return
        }
        
        let vcSafari = SFSafariViewController(url: url)
        present(vcSafari, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if (!DBManager.DB.checkLogin()) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnYourNews(_ sender: Any) {
        if (DBManager.DB.checkLogin()) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourNewsTableViewController") as! YourNewsTableViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotLoginViewController") as! NotLoginViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
}
