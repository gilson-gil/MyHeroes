//
//  UILabelBuilder.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class UILabelBuilder: Builder {
    private var size: CGFloat = 16
    private var weight: UIFont.Weight = .regular
    private var color: UIColor = .black
    private var numberOfLines: Int = 1

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
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.numberOfLines = numberOfLines
        return label
    }
}
