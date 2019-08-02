//
//  UIColor+Extension.swift
//  MyHeroes
//
//  Created by Gilson Gil on 01/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}

extension UIColor {
    static var marvelRed: UIColor {
        return UIColor(hex: Int(Constants.marvelRedColor.rawValue, radix: 16)!)
    }
}
