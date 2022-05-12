//
//  NewTableViewCell.swift
//  News
//  1
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

    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func btnNewsSave(_ sender: Any) {
        let addFavorNews = DBManager.DB.addFavorNews(article: articleDetail)
        if (addFavorNews) {
            btnSave.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            btnSave.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
}
