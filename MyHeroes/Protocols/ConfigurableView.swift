//
//  ConfigurableView.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ConfigurableView: class {
    associatedtype ViewModel

    func update(_ viewModel: ViewModel)
}

protocol ViewConfiguratorType {
    var viewClass: AnyClass { get }
    var reuseIdentifier: String { get }

    func getViewClass() -> AnyClass
    func update<T: ReusableView>(_ view: T)
    func register(_ tableView: UITableView?)
    func register(_ collectionView: UICollectionView?)
}

extension ViewConfiguratorType {
    func getViewClass() -> AnyClass {
        return viewClass
    }
}

struct ViewConfigurator<View> where View: ConfigurableView & ReusableView {
    let viewModel: View.ViewModel
    let viewClass: AnyClass = View.self
    var reuseIdentifier: String { return View.reuseIdentifier }

    func update<T: ReusableView>(_ view: T) {
        guard let view = view as? View else { return }
        view.update(viewModel)
    }

    func register(_ tableView: UITableView?) {
        if viewClass.isSubclass(of: UITableViewCell.self) {
            tableView?.register(viewClass, forCellReuseIdentifier: View.reuseIdentifier)
        } else if viewClass.isSubclass(of: UITableViewHeaderFooterView.self) {
            tableView?.register(viewClass, forHeaderFooterViewReuseIdentifier: View.reuseIdentifier)
        }
    }

    func register(_ collectionView: UICollectionView?) {
        collectionView?.register(viewClass, forCellWithReuseIdentifier: View.reuseIdentifier)
    }
}

extension ViewConfigurator: ViewConfiguratorType {}
