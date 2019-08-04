//
//  UITableView+ViewConfigurator.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UITableView {
    func register(configurator: ViewConfiguratorType) {
        if configurator.viewClass.isSubclass(of: UITableViewCell.self) {
            register(configurator.viewClass, forCellReuseIdentifier: configurator.reuseIdentifier)
        } else {
            register(configurator.viewClass, forHeaderFooterViewReuseIdentifier: configurator.reuseIdentifier)
        }
    }

    func register(configurators: [ViewConfiguratorType]) {
        configurators.forEach { register(configurator: $0) }
    }

    func register(sections: [[ViewConfiguratorType]]) {
        sections.forEach { register(configurators: $0) }
    }
}
