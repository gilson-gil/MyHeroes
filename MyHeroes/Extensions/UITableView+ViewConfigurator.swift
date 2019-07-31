//
//  UITableView+ViewConfigurator.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: ReusableView>(view: T.Type) {
        register(view, forCellReuseIdentifier: view.reuseIdentifier)
    }
}
