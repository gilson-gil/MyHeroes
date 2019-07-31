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

    func update<T: ConfigurableView>(_ view: T)
    func register(_ tableView: UITableView?)
}

struct ViewConfigurator<View> where View: ConfigurableView & ReusableView {
    let viewModel: View.ViewModel
    let viewClass: AnyClass = View.self

    func update<T: ConfigurableView>(_ view: T) {
        guard let view = view as? View else { return }
        view.update(viewModel)
    }

    func register(_ tableView: UITableView?) {
        tableView?.register(viewClass, forCellReuseIdentifier: View.reuseIdentifier)
    }
}

extension ViewConfigurator: ViewConfiguratorType {}
