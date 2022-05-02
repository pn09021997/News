//
//  NewTableViewCell.swift
//  News
//
//  Created by Nguyen Phuong on 10/02/1401 AP.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var newsCategory: UILabel!
    @IBOutlet weak var newsContent: UITextField!
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

}
