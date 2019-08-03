//
//  UILabelBuilder.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class UILabelBuilder {
    var size: CGFloat = 16
    var weight: UIFont.Weight = .regular
    var color: UIColor = .black
    var numberOfLines: Int = 1

    func setSize(_ size: CGFloat) -> Self {
        self.size = size
        return self
    }

    func setWeight(_ weight: UIFont.Weight) -> Self {
        self.weight = weight
        return self
    }

    func setColor(_ color: UIColor) -> Self {
        self.color = color
        return self
    }

    func setNumberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }

    func build() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.numberOfLines = numberOfLines
        return label
    }
}
