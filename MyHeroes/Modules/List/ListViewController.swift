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

    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = .init()
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private(set) lazy var loadingFooter: LoadingFooter = {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 44 + view.safeAreaInsets.bottom
        let size: CGSize = .init(width: width, height: height)
        let frame: CGRect = .init(origin: .zero, size: size)
        let footer: LoadingFooter = .init(frame: frame)
        footer.heightAnchor ||= height
        return footer
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
        collectionView.contentInset = view.safeAreaInsets
    }
}

extension ListViewController: ListView {
    func showNoContentScreen() {

    }

    func showListCharacters(_ viewModel: ListViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.viewModel.configurators.forEach { $0.register(self.collectionView) }
            self.collectionView.reloadData()
        }
    }

    func showPaginationLoading() {
        DispatchQueue.main.async {
//            self.collectionView.tableFooterView = self.loadingFooter
        }
    }

    func hidePaginationLoading() {
        DispatchQueue.main.async {
//            self.collectionView.tableFooterView = UIView()
        }
    }
}

extension ListViewController: ViewCodable {
    func addSubviews() {
        view.addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.autolayout.alignEdges(to: view)
    }
}

// MARK: - UICollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.configurators.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = viewModel.configurators[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier,
                                                      for: indexPath)
        configurator.update(cell)
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = width * 4 / 3
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

// MARK: - UIScrollView Delegate
extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height else { return }
        presenter.requestNextPage()
    }
}
