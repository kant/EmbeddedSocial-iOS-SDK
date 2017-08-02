//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
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
    
    func setEnabledUpdatingOpacity(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        alpha = isEnabled ? 1.0 : 0.5
    }
    
    /// Set the Button `image` with a `photo` and a placeholder.
    /// If `photo` has image, it's set immediately.
    /// If it has only URL, it's downloaded and cached.
    func setPhotoWithCaching(_ photo: Photo?, placeholder: UIImage?) {
        guard let photo = photo else {
            setImage(placeholder, for: .normal)
            return
        }
        
        if let image = photo.image {
            setImage(image.scaledToFit(toSize: CGSize(width: UIScreen.main.bounds.size.width - 40, height: 50)), for: .normal)
        } else if let cachedImage = ImageCacheAdapter.shared.image(for: photo) {
            setImage(cachedImage.scaledToFit(toSize: CGSize(width: UIScreen.main.bounds.size.width - 40, height: cachedImage.size.height)), for: .normal)
        } else if let url = photo.url {
            sd_setImage(with: URL(string: url), for: .normal, placeholderImage: placeholder)
        }
    }
}
