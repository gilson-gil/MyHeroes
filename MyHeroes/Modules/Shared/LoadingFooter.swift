//
//  LoadingFooter.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 01/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class LoadingFooter: UIView {
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

extension LoadingFooter: ViewCodable {
    var view: UIView! {
        return self
    }

    func addSubviews() {
        addSubview(activityIndicator)
    }

    func addConstraints() {
        activityIndicator.autolayout.center(to: self)
    }
}
