//
//  SubtitleTableCell.swift
//  MSGP
//
//  Created by Vadim Bulavin on 7/17/17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import UIKit

class SubtitleTableCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
}

extension SubtitleTableCell {
    struct Style {
        let titleColor: UIColor?
        let titleFont: UIFont
        let subTitleColor: UIColor?
        let subTitleFont: UIFont
        let backgroundColor: UIColor?
    }
}

extension SubtitleTableCell.Style {
    typealias Style = SubtitleTableCell.Style
    
    static var createAccountGroupHeader: Style {
        return Style(titleColor: nil,
                     titleFont: Fonts.regular,
                     subTitleColor: Palette.darkGrey,
                     subTitleFont: Fonts.regular,
                     backgroundColor: Palette.extraLightGrey)
    }
}

extension SubtitleTableCell {
    func apply(style: Style) {
        textLabel?.textColor = style.titleColor
        textLabel?.font = style.titleFont
        backgroundColor = style.backgroundColor
    }
}