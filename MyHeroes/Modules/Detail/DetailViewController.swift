//
//  DetailViewController.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    var presenter: DetailPresentation
    var viewModel: DetailViewModel

    private(set) var imageTextView: ImageTextViewInterface = {
        return ImageTextViewBuilder()
            .setCornerRadius(0)
            .setContentMode(.scaleAspectFill)
            .build()
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = .init()
        layout.estimatedItemSize = .init(width: view.bounds.width, height: 100)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private(set) lazy var blurredView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isHidden = true
        return view
    }()

    private var imageHeightConstraint: NSLayoutConstraint?
    private var blurredViewHeightConstraint: NSLayoutConstraint?

    init(presenter: DetailPresentation, viewModel: DetailViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        updateUI()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupView()
    }

    private func updateUI() {
        imageTextView.update(viewModel.imageTextViewModel)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func registerConfigurators() {
        for section in self.viewModel.configurators {
            self.collectionView.register(configurators: section.value)
        }
        for section in viewModel.headerConfigurators.values.compactMap({ $0 }) {
            self.collectionView.register(configurator: section)
        }
    }

    private func updateImageBounds(from scrollView: UIScrollView) {
        let offset = scrollView.contentInset.top + scrollView.contentOffset.y + view.safeAreaInsets.top
        let height = max(scrollView.bounds.width - offset, view.safeAreaInsets.top)
        imageHeightConstraint?.constant = height
    }

    private func updateBlurredView(from scrollView: UIScrollView) {
        if scrollView.contentOffset.y > -view.safeAreaInsets.top {
            blurredView.isHidden = false
            navigationItem.title = viewModel.character?.name
        } else {
            blurredView.isHidden = true
            navigationItem.title = nil
        }
    }
}

extension DetailViewController: DetailView {
    func showDetails(_ character: Character) {
        DispatchQueue.main.async {
            self.viewModel.character = character
            self.updateUI()
        }
    }

    func showComics(_ comics: DataState<[DetailItemViewModel]>) {
        viewModel.comics = comics
        DispatchQueue.main.async {
            self.registerConfigurators()
            self.collectionView.reloadSections(.init(integer: DetailSectionType.comics.rawValue))
        }
    }

    func showEvents(_ events: DataState<[DetailItemViewModel]>) {
        viewModel.events = events
        DispatchQueue.main.async {
            self.registerConfigurators()
            self.collectionView.reloadSections(.init(integer: DetailSectionType.events.rawValue))
        }
    }

    func showStories(_ stories: DataState<[DetailItemViewModel]>) {
        viewModel.stories = stories
        DispatchQueue.main.async {
            self.registerConfigurators()
            self.collectionView.reloadSections(.init(integer: DetailSectionType.stories.rawValue))
        }
    }

    func showSeries(_ series: DataState<[DetailItemViewModel]>) {
        viewModel.series = series
        DispatchQueue.main.async {
            self.registerConfigurators()
            self.collectionView.reloadSections(.init(integer: DetailSectionType.series.rawValue))
        }
    }

    func showError(_ error: Error) {
        DispatchQueue.main.async { [weak navigationController] in
            self.alert(title: nil, message: error.localizedDescription, cancelTitle: "OK", cancelAction: {
                navigationController?.popViewController(animated: true)
            })
        }
    }
}

extension DetailViewController: ViewCodable {
    func setupView() {
        view.backgroundColor = .black
        registerConfigurators()
        configureTableViewInsets()
        blurredViewHeightConstraint?.constant = view.safeAreaInsets.top
    }

    private func configureTableViewInsets() {
        view.layoutIfNeeded()
        var inset = collectionView.contentInset
        inset.top = imageTextView.bounds.height - view.safeAreaInsets.top
        collectionView.contentInset = inset
        collectionView.setContentOffset(.init(x: 0, y: -imageTextView.bounds.height), animated: false)
    }

    func addSubviews() {
        view.addSubview(imageTextView)
        view.addSubview(collectionView)
        view.addSubview(blurredView)
    }

    func addConstraints() {
        imageTextView.autolayout.alignTop(to: view)
        imageTextView.autolayout.alignLeft(to: view)
        imageTextView.autolayout.alignRight(to: view)
        imageHeightConstraint = imageTextView.autolayout.setHeight(to: view.bounds.width)

        collectionView.autolayout.alignEdges(to: view)

        blurredView.autolayout.alignTop(to: view)
        blurredView.autolayout.alignLeft(to: view)
        blurredView.autolayout.alignRight(to: view)
        blurredViewHeightConstraint = blurredView.autolayout.setHeight(to: 88)
    }
}

// MARK: - UICollectionView DataSource
extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.configurators.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.configurators[section]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let configurator = viewModel.configurators[indexPath.section]?[indexPath.item] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 80
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let value = viewModel.headerConfigurators[indexPath.section], let configurator = value else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: configurator.reuseIdentifier,
                                                                     for: indexPath)
        configurator.update(header)
        return header
    }
}

// MARK: - UIScrollView Delegate
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateImageBounds(from: scrollView)
        updateBlurredView(from: scrollView)
    }
}
