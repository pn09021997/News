//
//  YourNewsTableViewCell.swift
//  News
//
//  Created by Nguyen Phuong on 19/02/1401 AP.
//

import UIKit

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
