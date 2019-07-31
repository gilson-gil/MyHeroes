//
//  ListViewController.swift
//  MyHeroes
//
//  Created by Gilson Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    var presenter: ListPresentation

    init(presenter: ListPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListViewController: ListView {
    func showNoContentScreen() {

    }

    func showListCharacters(_ viewModel: ListViewModel) {

    }
}

extension ListViewController: ViewCodable {
    func addSubviews() {

    }

    func addConstraints() {

    }
}
