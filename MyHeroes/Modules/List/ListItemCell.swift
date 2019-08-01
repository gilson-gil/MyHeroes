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
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.5
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
            .setColor(.black)
            .setWeight(.medium)
            .setNumberOfLines(0)
            .build()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension ListItemCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
    }

    func addConstraints() {
        containerView.topAnchor ||= contentView.topAnchor ||+ 20
        containerView.leftAnchor ||= contentView.leftAnchor ||+ 20
        containerView.rightAnchor ||= contentView.rightAnchor ||+ 20
        containerView.heightAnchor ||= 100 ||~ 750

        itemImageView.autolayout.alignEdges(to: contentView)

        titleLabel.leftAnchor ||= contentView.leftAnchor ||+ 20
        titleLabel.rightAnchor ||= contentView.rightAnchor ||- 20
        titleLabel.bottomAnchor ||= contentView.bottomAnchor
    }
}

extension ListItemCell: ConfigurableView {
    func update(_ viewModel: ListItemViewModel) {
        itemImageView.downloader.fetchImage(for: viewModel.imageUrl) {}
        titleLabel.text = viewModel.title
    }
}
