//
//  HeaderView.swift
//  News
//
//  Created by Nguyen Phuong on 09/02/1401 AP.
//

import UIKit

final class HeaderView: UIView {
    private var fontSize: CGFloat
    private lazy var headingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "News"
        v.font = UIFont.boldSystemFont(ofSize: fontSize)
        return v
    }()
}
