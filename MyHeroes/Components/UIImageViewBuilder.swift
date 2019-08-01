//
//  UIImageViewBuilder.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class UIImageViewBuilder {
    var contentMode: UIImageView.ContentMode = .scaleAspectFit

    func setContentMode(_ contentMode: UIImageView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    func build() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = contentMode
        return imageView
    }
}
