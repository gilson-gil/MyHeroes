//
//  TodayItemCell.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class TodayItemCell: UICollectionViewCell {
    private(set) var imageView: UIImageView = {
        return UIImageViewBuilder()
            .setContentMode(.scaleAspectFit)
            .build()
    }()

    private(set) var label: UILabel = {
        return UILabelBuilder()
            .setNumberOfLines(2)
            .setColor(.black)
            .setSize(14)
            .setWeight(.bold)
            .build()
    }()

    private lazy var downloadManager: DownloadManager = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

extension TodayItemCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }

    func addConstraints() {
        imageView.autolayout.alignTop(to: contentView)
        imageView.autolayout.alignLeft(to: contentView, padding: 16)
        imageView.autolayout.alignBottom(to: contentView)
        imageView.autolayout.setRatio(to: 1)

        label.autolayout.alignTop(to: imageView)
        label.autolayout.setLeft(to: imageView, padding: 16)
        label.autolayout.alignBottom(to: imageView)
        label.autolayout.alignRight(to: contentView, padding: 16)
    }
}

extension TodayItemCell: ConfigurableView {
    func update(_ viewModel: TodayItemViewModel) {
        imageView.startLoading()
        downloadManager.fetchImage(for: viewModel.imageUrl) { [weak imageView] image in
            DispatchQueue.main.async {
                imageView?.stopLoading()
                imageView?.image = image
            }
        }
        label.text = viewModel.title
    }
}
