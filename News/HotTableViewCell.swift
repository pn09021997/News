//
//  HotTableViewCell.swift
//  News
//
//  Created by Nguyen Phuong on 12/02/1401 AP.
//

import UIKit
class HotTableViewCellModel {
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
class HotTableViewCell: UITableViewCell {
    static let identifier = "HotTableViewCell"
    public var articleDetail: Article?
    weak var viewController: UIViewController?
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnSaveNews(_ sender: Any) {
        if (DBManager.DB.checkLogin()) {
            let addFavorNews = DBManager.DB.addFavorNews(article: articleDetail)
            if (addFavorNews) {
                btnSave.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            } else {
                btnSave.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
        } else {
            // create the alert
            let alert = UIAlertController(title: "Title", message: "You need login first !", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
}
