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
        collectionView.register(view: LoadingCollectionViewCell.self)
        return collectionView
    }()

    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = .init()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshChanged(sender:)), for: .valueChanged)
        return refreshControl
    }()

    private(set) lazy var emptyLabel: UILabel = {
        return UILabelBuilder()
            .setColor(.white)
            .setSize(20)
            .setWeight(.semibold)
            .setNumberOfLines(0)
            .setText("Não há conteúdo disponível, tente novamente mais tarde")
            .setTextAlignment(.center)
            .build()
    }()

    init(presenter: ListPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        presenter.requestFirstPage(force: false)
    }

    private func updateUI() {
        collectionView.contentInset = view.safeAreaInsets
    }

    @objc
    func refreshChanged(sender: UIRefreshControl) {
        presenter.requestFirstPage(force: true)
    }
}

extension ListViewController: ListView {
    func showNoContentScreen() {
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.collectionView.backgroundView = self.emptyLabel
        }
    }

    func showError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.alert(title: nil, message: error.localizedDescription, cancelTitle: "OK", cancelAction: {
                self?.showNoContentScreen()
            })
        }
    }

    func showLoading() {
        guard !refreshControl.isRefreshing else { return }
        collectionView.contentOffset = CGPoint(x: 0, y: -refreshControl.bounds.height)
        refreshControl.beginRefreshing()
    }

    func showListCharacters(_ viewModel: ListViewModel) {
        let previousCount = self.viewModel.configurators.count
        let newCount = viewModel.configurators.count
        let range = newCount <= previousCount ? 0..<newCount : previousCount..<newCount
        let newIndexPaths = range.map { IndexPath(item: $0, section: 0) }
        self.viewModel = viewModel
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.viewModel.configurators.forEach { $0.register(self.collectionView) }
            if range.lowerBound == 0 {
                self.collectionView.reloadData()
            } else {
                self.collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: newIndexPaths)
                    if self.collectionView.numberOfItems(inSection: 1) > 0 {
                        self.collectionView.deleteItems(at: [IndexPath(item: 0, section: 1)])
                    }
                }, completion: nil)
            }
        }
    }

    func showPaginationLoading() {
        DispatchQueue.main.async {
            self.viewModel.isLoadingNextPage = true
            self.collectionView.reloadSections(.init(integer: 1))
        }
    }

    func hidePaginationLoading() {
        DispatchQueue.main.async {
            self.viewModel.isLoadingNextPage = false
            self.collectionView.reloadSections(.init(integer: 1))
        }
    }
}

extension ListViewController: ViewCodable {
    func addSubviews() {
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        navigationItem.titleView = UIImageViewBuilder()
            .setContentMode(.scaleAspectFit)
            .setImage(#imageLiteral(resourceName: "img_logo"))
            .build()
    }

    func addConstraints() {
        collectionView.autolayout.alignEdges(to: view)
    }
}

// MARK: - UICollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.configurators.count
        } else {
            return viewModel.isLoadingNextPage ? 1 : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let configurator = viewModel.configurators[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier,
                                                          for: indexPath)
            configurator.update(cell)
            return cell
        } else {
            let configurator = ViewConfigurator<LoadingCollectionViewCell>(viewModel: nil)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier,
                                                          for: indexPath)
            configurator.update(cell)
            return cell
        }
    }
}

// MARK: - UICollectionView Delegate
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat
        if indexPath.section == 0 {
            height = width
        } else {
            height = 44
        }
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.characters.count else { return }
        presenter.didSelectCharacter(viewModel.characters[indexPath.item])
    }
}

// MARK: - UIScrollView Delegate
extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > scrollView.contentSize.height - 2 * scrollView.bounds.height else { return }
        presenter.requestNextPage()
    }
}
