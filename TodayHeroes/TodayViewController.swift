//
//  TodayViewController.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit
import NotificationCenter
import MyHeroesAPI

@objc(TodayViewController)
final class TodayViewController: UIViewController, NCWidgetProviding {
    var router: TodayWireframe?
    var presenter: TodayPresentation?
    var viewModel: TodayViewModel = .init()
    var cellHeight: CGFloat { return 110 }
    var cellSeparator: CGFloat { return 8 }

    private var widgetCompletionHandler: ((NCUpdateResult) -> Void)?

    private(set) lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = .init()
        layout.minimumLineSpacing = self.cellSeparator
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private(set) var collectionViewHeightConstraint: NSLayoutConstraint?

    override func loadView() {
        super.loadView()
        setupViewCode()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = TodayRouter.startModule(from: self)
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            refreshContentSize()
        case .expanded:
            var size = maxSize
            size.height = cellHeight * CGFloat(viewModel.configurators.count)
                + cellSeparator * CGFloat(viewModel.configurators.count - 1)
            preferredContentSize = size
        @unknown default:
            fatalError()
        }
        collectionView.reloadData()
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        refreshContentSize()
        presenter?.didRequestUpdate()
        widgetCompletionHandler = completionHandler
        collectionView.startLoading()
    }

    func refreshContentSize() {
        let width: CGFloat = 0
        let height: CGFloat = cellHeight * CGFloat(viewModel.configurators.count)
            + cellSeparator * CGFloat(viewModel.configurators.count - 1)
        preferredContentSize = .init(width: width, height: height)
        collectionViewHeightConstraint?.constant = height
    }
}

extension TodayViewController: ViewCodable {
    func addSubviews() {
        view.addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.autolayout.alignEdges(to: view)
        collectionViewHeightConstraint = collectionView.autolayout.setHeight(to: 110, priority: 900)
    }
}

extension TodayViewController: TodayView {
    func showNoContentScreen() {
        DispatchQueue.main.async {
            self.widgetCompletionHandler?(.noData)
            self.widgetCompletionHandler = nil
            self.collectionView.stopLoading()
        }
    }

    func showListCharacters(_ viewModel: TodayViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.refreshContentSize()
            self.collectionView.register(configurators: viewModel.configurators)
            self.collectionView.register(configurators: viewModel.compactConfigurators)
            self.collectionView.reloadData()
            self.widgetCompletionHandler?(.newData)
            self.widgetCompletionHandler = nil
            self.collectionView.stopLoading()
        }
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if extensionContext?.widgetActiveDisplayMode == .some(.compact) {
            return viewModel.compactConfigurators.count
        } else {
            return viewModel.configurators.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator: ViewConfiguratorType
        if extensionContext?.widgetActiveDisplayMode == .some(.compact) {
            configurator = viewModel.compactConfigurators[indexPath.item]
        } else {
            configurator = viewModel.configurators[indexPath.item]
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        return cell
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat
        if extensionContext?.widgetActiveDisplayMode == .some(.compact) {
            width = cellHeight
        } else {
            width = collectionView.bounds.width
        }
        let height: CGFloat = cellHeight
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.item]
        presenter?.didSelectCharacter(character)
    }
}
