//
//  UIActivityIndicatorBuilder.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 01/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class UIActivityIndicatorBuilder {
    var tintColor: UIColor = .black
    var isAnimating: Bool = false

    func setTintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    func setIsAnimating(_ isAnimating: Bool) -> Self {
        self.isAnimating = isAnimating
        return self
    }

    func build() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = tintColor
        if isAnimating {
            view.startAnimating()
        }
        return view
    }
}
