//
//  ListItemCell.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ListItemCell: UICollectionViewCell {
    private(set) var imageTextView: ImageTextViewInterface = {
        return ImageTextViewBuilder()
            .setCornerRadius(20)
            .build()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTextView.clearContext()
    }
}

extension ListItemCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(imageTextView)
    }

    func addConstraints() {
        imageTextView.autolayout.alignTop(to: contentView, padding: 20)
        imageTextView.autolayout.alignLeft(to: contentView, padding: 20)
        imageTextView.autolayout.alignRight(to: contentView, padding: 20)
        imageTextView.autolayout.setRatio(to: 1)
    }
}

extension ListItemCell: ConfigurableView {
    func update(_ viewModel: ListItemViewModel) {
        let imageTextViewModel = ImageTextViewModel(text: viewModel.title,
                                                    imageUrl: viewModel.imageUrl)
        imageTextView.update(imageTextViewModel)
    }
}
