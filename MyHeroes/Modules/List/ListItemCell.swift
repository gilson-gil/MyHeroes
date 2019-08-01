//
//  ListItemCell.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ListItemCell: UITableViewCell {
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension ListItemCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
    }

    func addConstraints() {
        itemImageView.topAnchor >> contentView.topAnchor + 20
        itemImageView.leftAnchor >> contentView.leftAnchor + 20
        itemImageView.bottomAnchor >> contentView.bottomAnchor - 20

        itemImageView.widthAnchor >> 100
        itemImageView.heightAnchor >> 100

        titleLabel.leftAnchor >> itemImageView.rightAnchor + 20
        titleLabel.rightAnchor >> contentView.rightAnchor - 20
        titleLabel.centerYAnchor >> contentView.centerYAnchor
    }
}

extension ListItemCell: ConfigurableView {
    func update(_ viewModel: ListItemViewModel) {
        itemImageView.downloader.fetchImage(for: viewModel.imageUrl) {}
        titleLabel.text = viewModel.title
    }
}
