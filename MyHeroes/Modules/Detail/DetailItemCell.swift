//
//  DetailItemCell.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class DetailItemCell: UICollectionViewCell {
    private(set) var itemImageView: UIImageView = {
        return UIImageViewBuilder()
            .setContentMode(.scaleAspectFit)
            .build()
    }()

    private(set) var titleLabel: UILabel = {
        return UILabelBuilder()
            .setColor(.white)
            .setNumberOfLines(2)
            .setWeight(.medium)
            .setSize(16)
            .build()
    }()

    private(set) var descriptionLabel: UILabel = {
        return UILabelBuilder()
            .setColor(.white)
            .setNumberOfLines(0)
            .setWeight(.regular)
            .setSize(14)
            .build()
    }()

    private var contentViewWidthConstraint: NSLayoutConstraint?

    private lazy var downloadManager: DownloadManager = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        contentViewWidthConstraint?.constant = bounds.width
        return contentView.systemLayoutSizeFitting(.init(width: targetSize.width, height: 1))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
}

extension DetailItemCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func setupView() {
        contentView.backgroundColor = .black
    }

    func addSubviews() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    func addConstraints() {
        contentView.autolayout.alignEdges(to: self)
        contentViewWidthConstraint = contentView.autolayout.setWidth(to: bounds.width)

        itemImageView.autolayout.alignTop(to: contentView, padding: 20)
        itemImageView.autolayout.alignLeft(to: contentView, padding: 20)
        itemImageView.autolayout.setWidth(to: 60)
        itemImageView.autolayout.setHeight(to: 60)
        itemImageView.bottomAnchor ||<= contentView.bottomAnchor - 20

        titleLabel.autolayout.alignTop(to: itemImageView)
        titleLabel.autolayout.setLeft(to: itemImageView, padding: 20)
        titleLabel.autolayout.alignRight(to: contentView, padding: 20)

        descriptionLabel.autolayout.setTop(to: titleLabel, padding: 8)
        descriptionLabel.autolayout.alignLeft(to: titleLabel)
        descriptionLabel.autolayout.alignRight(to: titleLabel)
        descriptionLabel.autolayout.alignBottom(to: contentView, padding: 20, priority: 750)
        descriptionLabel.bottomAnchor ||<= contentView.bottomAnchor - 20
    }
}

extension DetailItemCell: ConfigurableView {
    func update(_ viewModel: DetailItemViewModel) {
        if let imageUrl = viewModel.imageUrl {
            itemImageView.startLoading()
            downloadManager.fetchImage(for: imageUrl) { [weak itemImageView] image in
                DispatchQueue.main.async {
                    itemImageView?.stopLoading()
                    itemImageView?.image = image
                }
            }
        }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}
