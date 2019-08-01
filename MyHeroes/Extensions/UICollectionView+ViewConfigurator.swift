//
//  UICollectionView+ViewConfigurator.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 01/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: ReusableView>(view: T.Type) {
        register(view, forCellWithReuseIdentifier: view.reuseIdentifier)
    }
}
