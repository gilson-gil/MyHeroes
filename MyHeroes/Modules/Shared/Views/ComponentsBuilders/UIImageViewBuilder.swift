//
//  UIImageViewBuilder.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class UIImageViewBuilder: Builder {
    private var contentMode: UIImageView.ContentMode = .scaleAspectFit
    private var image: UIImage?

    func setContentMode(_ contentMode: UIImageView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    func setImage(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    func build() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.image = image
        return imageView
    }
}
