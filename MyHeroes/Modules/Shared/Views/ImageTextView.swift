//
//  ImageTextView.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ImageTextViewInterface: UIView {
    func clearContext()
    func update(_ viewModel: ImageTextViewModel)
}

final class ImageTextView: UIView {
    private(set) var imageView: UIImageView = {
        return UIImageViewBuilder()
            .setContentMode(.scaleAspectFit)
            .build()
    }()

    private(set) var titleLabel: UILabel = {
        return UILabelBuilder()
            .setSize(20)
            .setColor(.white)
            .setWeight(.medium)
            .setNumberOfLines(0)
            .build()
    }()

    private let gradientLayer: CAGradientLayer = {
        let layer: CAGradientLayer = .init()
        layer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        layer.locations = [0, 0.7, 1]
        layer.type = .axial
        return layer
    }()

    private lazy var downloadManager: DownloadManager = .init()

    private var boundsObserver: NSKeyValueObservation!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()

        boundsObserver = observe(\.bounds, changeHandler: { [weak gradientLayer] view, _ in
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientLayer?.frame = view.bounds
            CATransaction.commit()
        })
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    convenience init() {
        self.init(frame: .zero)
    }
}

// MARK: - ViewCodable
extension ImageTextView: ViewCodable {
    var view: UIView! {
        return self
    }

    func addSubviews() {
        addSubview(imageView)
        layer.addSublayer(gradientLayer)
        addSubview(titleLabel)
    }

    func addConstraints() {
        imageView.autolayout.alignEdges(to: self)

        titleLabel.autolayout.alignLeft(to: self, padding: 20)
        titleLabel.autolayout.alignRight(to: self, padding: 20)
        titleLabel.autolayout.alignBottom(to: self, padding: 20)
    }
}

// MARK: - ImageTextView Interface
extension ImageTextView: ImageTextViewInterface {
    func clearContext() {
        imageView.image = nil
    }
}

// MARK: - ConfigurableView
extension ImageTextView: ConfigurableView {
    func update(_ viewModel: ImageTextViewModel) {
        if let imageUrl = viewModel.imageUrl {
            imageView.startLoading()
            downloadManager.fetchImage(for: imageUrl) { [weak imageView] image in
                DispatchQueue.main.async {
                    imageView?.stopLoading()
                    imageView?.image = image
                }
            }
        }
        titleLabel.text = viewModel.text
    }
}
