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
    var loadingIndicatorView: LoadingIndicatorView? { get }

    func createLoadingIndicator() -> LoadingIndicatorView
    func addSubview(_ view: UIView)
    func startLoading()
    func stopLoading()
}

extension LoadingStateView {
    var loadingIndicatorView: LoadingIndicatorView? {
        return subviews.compactMap { $0 as? LoadingIndicatorView }.first
    }

    func createLoadingIndicator() -> LoadingIndicatorView {
        let indicatorView: UIActivityIndicatorView = .init(style: .white)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }

    func startLoading() {
        if loadingIndicatorView == nil {
            let loadingIndicatorView = createLoadingIndicator()
            addSubview(loadingIndicatorView)
            loadingIndicatorView.autolayout.center(to: self)
        }
        loadingIndicatorView?.startAnimating()
    }

    func stopLoading() {
        loadingIndicatorView?.stopAnimating()
    }
}

extension UIActivityIndicatorView: LoadingIndicatorView {}

extension UIImageView: LoadingStateView {}
