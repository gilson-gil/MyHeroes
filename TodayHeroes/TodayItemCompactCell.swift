//
//  TodayItemCompactCell.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class TodayItemCompactCell: UICollectionViewCell {
    private(set) var imageTextView: ImageTextViewInterface = {
        return ImageTextViewBuilder()
            .setCornerRadius(20)
            .setTextSize(14)
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

extension TodayItemCompactCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(imageTextView)
    }

    func addConstraints() {
        imageTextView.autolayout.alignTop(to: contentView)
        imageTextView.autolayout.alignLeft(to: contentView)
        imageTextView.autolayout.alignRight(to: contentView)
        imageTextView.autolayout.setRatio(to: 1)
    }
}

extension TodayItemCompactCell: ConfigurableView {
    func update(_ viewModel: TodayItemViewModel) {
        let imageTextViewModel = ImageTextViewModel(text: viewModel.title,
                                                    imageUrl: viewModel.imageUrl)
        imageTextView.update(imageTextViewModel)
    }
}
