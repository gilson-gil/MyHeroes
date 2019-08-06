//
//  LoadingStateView.swift
//  MyHeroes
//
//  Created by Gilson Gil on 02/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol LoadingIndicatorView: UIView {
    var isAnimating: Bool { get }

    func startAnimating()
    func stopAnimating()
}

protocol LoadingStateView: UIView {
    var loadingIndicatorSuperview: UIView { get }
    var loadingIndicatorView: LoadingIndicatorView? { get }

    func createLoadingIndicator() -> LoadingIndicatorView
    func addSubview(_ view: UIView)
    func startLoading()
    func stopLoading()
}

extension LoadingStateView {
    var loadingIndicatorSuperview: UIView {
        return self
    }

    var loadingIndicatorView: LoadingIndicatorView? {
        return loadingIndicatorSuperview.subviews.compactMap { $0 as? LoadingIndicatorView }.first
    }

    func createLoadingIndicator() -> LoadingIndicatorView {
        return UIActivityIndicatorBuilder()
            .build()
    }

    func startLoading() {
        if loadingIndicatorView == nil {
            let loadingIndicatorView = createLoadingIndicator()
            loadingIndicatorSuperview.addSubview(loadingIndicatorView)
            loadingIndicatorView.autolayout.center(to: loadingIndicatorSuperview)
        }
        loadingIndicatorView?.startAnimating()
    }

    func stopLoading() {
        loadingIndicatorView?.stopAnimating()
    }
}

extension UIActivityIndicatorView: LoadingIndicatorView {}

extension UIImageView: LoadingStateView {}

extension UICollectionView: LoadingStateView {}
