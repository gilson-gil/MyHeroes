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

    func register(configurator: ViewConfiguratorType) {
        if configurator.viewClass.isSubclass(of: UICollectionViewCell.self) {
            register(configurator.viewClass, forCellWithReuseIdentifier: configurator.reuseIdentifier)
        } else {
            register(configurator.viewClass,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: configurator.reuseIdentifier)
        }
    }

    func register(configurators: [ViewConfiguratorType]) {
        configurators.forEach { register(configurator: $0) }
    }

    func register(sections: [[ViewConfiguratorType]]) {
        sections.forEach { register(configurators: $0) }
    }
}
