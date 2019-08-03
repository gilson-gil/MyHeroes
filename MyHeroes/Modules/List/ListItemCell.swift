//
//  ListItemCell.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ListItemCell: UICollectionViewCell {
    private(set) var containerView: UIView = {
        let view: UIView = .init()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private(set) var itemImageView: UIImageView = {
        return UIImageViewBuilder()
            .setContentMode(.scaleAspectFit)
            .build()
    }()

    private(set) var titleLabel: UILabel = {
        return UILabelBuilder()
            .setSize(20)
            .setColor(.white)
            .setWeight(.medium)
            .setNumberOfLines(0)
            .build()
    }()

    private let gradientLayer: CAGradientLayer = {
        let layer: CAGradientLayer = .init()
        layer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        layer.locations = [0, 0.7, 1]
        layer.type = .axial
        return layer
    }()

    private lazy var downloadManager: DownloadManager = .init()

    private var boundsObserver: NSKeyValueObservation!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()

        boundsObserver = containerView.observe(\.bounds, changeHandler: { [weak gradientLayer] view, _ in
            gradientLayer?.frame = view.bounds
        })
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
}

extension ListItemCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.layer.addSublayer(gradientLayer)
        containerView.addSubview(titleLabel)
    }

    func addConstraints() {
        containerView.autolayout.alignTop(to: contentView, padding: 20)
        containerView.autolayout.alignLeft(to: contentView, padding: 20)
        containerView.autolayout.alignRight(to: contentView, padding: 20)
        containerView.autolayout.setRatio(to: 1)

        itemImageView.autolayout.alignEdges(to: containerView)

        titleLabel.autolayout.alignLeft(to: containerView, padding: 20)
        titleLabel.autolayout.alignRight(to: containerView, padding: 20)
        titleLabel.autolayout.alignBottom(to: containerView, padding: 20)
    }
}

extension ListItemCell: ConfigurableView {
    func update(_ viewModel: ListItemViewModel) {
        itemImageView.startLoading()
        downloadManager.fetchImage(for: viewModel.imageUrl) { [weak itemImageView] image in
            DispatchQueue.main.async {
                itemImageView?.stopLoading()
                itemImageView?.image = image
            }
        }
        titleLabel.text = viewModel.title
    }
}
