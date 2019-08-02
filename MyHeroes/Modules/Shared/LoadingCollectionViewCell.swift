//
//  LoadingCollectionViewCell.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 02/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class LoadingCollectionViewCell: UICollectionViewCell {
    private(set) var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorBuilder()
            .setTintColor(.black)
            .setIsAnimating(true)
            .build()
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension LoadingCollectionViewCell: ViewCodable {
    var view: UIView! {
        return contentView
    }

    func addSubviews() {
        contentView.addSubview(activityIndicator)
    }

    func addConstraints() {
        activityIndicator.autolayout.center(to: contentView)
    }
}

extension LoadingCollectionViewCell: ConfigurableView {
    func update(_ viewModel: Any?) {
        activityIndicator.startAnimating()
    }
}
