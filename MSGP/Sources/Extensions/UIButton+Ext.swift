//
//  UIButton+Ext.swift
//  MSGP
//
//  Created by Vadim Bulavin on 7/17/17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import UIKit

extension UIButton {
    
    static func makeButton(asset: Asset?, title: String? = nil, font: UIFont? = nil,
                           color: UIColor, action: (() -> Void)?) -> UIButton {
        let button = ButtonWithTarget(type: .system)
        if let asset = asset {
            button.setImage(UIImage(asset: asset), for: .normal)
        }
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.tintColor = color
        button.setTitleColor(color, for: .normal)
        button.onPrimaryActionTriggered = action
        button.sizeToFit()
        return button
    }
}