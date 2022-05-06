//
//  NewTableViewCell.swift
//  News
//
//  Created by Nguyen Phuong on 10/02/1401 AP.
//

import UIKit
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
    @IBOutlet weak var newsContent: UITextField!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
