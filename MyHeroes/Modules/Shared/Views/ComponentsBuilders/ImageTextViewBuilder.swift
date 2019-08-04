//
//  ImageTextViewBuilder.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ImageTextViewBuilder: Builder {
    private var cornerRadius: CGFloat = 20
    private var contentMode: UIImageView.ContentMode = .scaleAspectFit

    func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        return self
    }

    func setContentMode(_ contentMode: UIImageView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    func build() -> ImageTextView {
        let imageTextView: ImageTextView = .init()
        imageTextView.layer.masksToBounds = true
        imageTextView.layer.cornerRadius = cornerRadius
        imageTextView.imageView.contentMode = contentMode
        return imageTextView
    }
}
