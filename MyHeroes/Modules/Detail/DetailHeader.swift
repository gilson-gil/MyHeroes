//
//  DetailHeader.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class DetailHeader: UICollectionReusableView {
    private(set) var label: UILabel = {
        return UILabelBuilder()
            .setSize(30)
            .setColor(.white)
            .setWeight(.medium)
            .setNumberOfLines(1)
            .build()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension DetailHeader: ViewCodable {
    var view: UIView! {
        return self
    }

    func setupView() {
        backgroundColor = .black
    }

    func addSubviews() {
        addSubview(label)
    }

    func addConstraints() {
        label.autolayout.alignEdges(to: self, padding: 20)
    }
}

extension DetailHeader: ConfigurableView {
    func update(_ viewModel: String) {
        label.text = viewModel
    }
}
