//
//  ViewCodable.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ViewCodable: class {
    var view: UIView! { get }

    func setupViewCode()
    func addSubviews()
    func addConstraints()
}

extension ViewCodable {
    func setupViewCode() {
        addSubviews()
        addConstraints()
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
