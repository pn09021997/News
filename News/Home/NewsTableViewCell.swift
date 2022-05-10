//
//  NewTableViewCell.swift
//  News
//
//  Created by Nguyen Phuong on 10/02/1401 AP.
//

import UIKit
import Firebase

class NewsTableViewCellModel {
    let title: String
    let subTitle: String
    let imageURL: URL?
    var imageData: Data?
    
    init(
        title: String,
        subTitle: String,
        imageURL: URL?
    ) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    public var articleDetail: Article?
    private var checkFavorNews = true
    private var articleID = ""
    @IBOutlet weak var newsContent: UITextField!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func btnNewsSave(_ sender: Any) {
        let userID = "-N1HpCU9jKvHNEzRPTrf"
        let ref = Database.database().reference()
        let myaccount = ref.child("YourNews/\(userID)").observeSingleEvent(of: .value){
            (snapshot) in let listNews = snapshot.value as? NSDictionary
             
            if let listNews = listNews {
                for (key, value) in listNews {
                    let favorNews = value as? NSDictionary
                    let urlTxt = favorNews?.value(forKey: "url") as! String
                    if (self.articleDetail?.url == urlTxt) {
                        self.articleID = key as! String
                        self.checkFavorNews = false
                    }
                }
            }
        }

        
        if (checkFavorNews == true) {
            if let article = articleDetail{
                let articlesArr = [
                    "title": article.title,
                    "description": article.description ?? "No Description",
                    "url": article.url,
                    "urlToImage": article.urlToImage ?? "default",
                    "publishedAt": article.publishedAt
                ]
                ref.child("YourNews/\(userID)").childByAutoId().setValue(articlesArr)
            }
        } else {
            print("We have it on DB")
            ref.child("YourNews/\(userID)").child(articleID).removeValue()
            self.checkFavorNews = true
        }
    }
}
