//
//  YourNewsTableViewCell.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit
class YourNewsTableViewCellModel {
    let title: String
    let subTitle: String
    let url: String
    let imageURL: URL?
    var imageData: Data?
    
    init(
        title: String,
        subTitle: String,
        url: String,
        imageURL: URL?
    ) {
        self.title = title
        self.subTitle = subTitle
        self.url = url
        self.imageURL = imageURL
    }
}

class YourNewsTableViewCell: UITableViewCell {
    static let identifier = "YourNewsTableViewCell"
    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
