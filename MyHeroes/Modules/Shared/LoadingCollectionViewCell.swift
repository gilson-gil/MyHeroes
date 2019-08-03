//
//  LoadingCollectionViewCell.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 02/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class LoadingCollectionViewCell: UICollectionViewCell {}

extension LoadingCollectionViewCell: ConfigurableView {
    func update(_ viewModel: Any?) {
        startLoading()
    }
}

extension LoadingCollectionViewCell: LoadingStateView {
    func createLoadingIndicator() -> LoadingIndicatorView {
        return UIActivityIndicatorBuilder()
            .setTintColor(.black)
            .setIsAnimating(true)
            .build()
    }

    var loadingIndicatorSuperview: UIView {
        return contentView
    }
}
