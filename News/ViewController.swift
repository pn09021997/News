//
//  ViewController.swift
//  News
//
//  Created by Nguyen Phuong on 07/02/1401 AP.
//

import UIKit
/*struct Test {
    let name: String
}*/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
       
        /*NetworkManager.shared.getNews { (news) in
            guard let news = news else {
                return
            }
            let test = Test(name: news[0].title!)
            print(test.name)
            if (test.name != nil) {
                print("we have it")
            } else {
                print("Something went wrong")
            }
            
        }*/
    }
}

