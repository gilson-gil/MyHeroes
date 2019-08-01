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
    var viewModel: ListViewModel = .init()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init(presenter: ListPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension ListViewController: ListView {
    func showNoContentScreen() {

    }

    func showListCharacters(_ viewModel: ListViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.viewModel.configurators.forEach { $0.register(self.tableView) }
            self.tableView.reloadData()
        }
    }
}

extension ListViewController: ViewCodable {
    func addSubviews() {
        view.addSubview(tableView)
    }

    func addConstraints() {
        tableView.topAnchor >> view.safeAreaLayoutGuide.topAnchor
        tableView.leftAnchor >> view.safeAreaLayoutGuide.leftAnchor
        tableView.bottomAnchor >> view.bottomAnchor
        tableView.rightAnchor >> view.safeAreaLayoutGuide.rightAnchor
    }
}

// MARK: - UITableView DataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.configurators.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = viewModel.configurators[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        return cell
    }
}

// MARK: - UITableView Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
