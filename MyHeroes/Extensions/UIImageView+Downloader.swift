//
//  UIImageView+Downloader.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

struct Downloader {
    weak var imageView: UIImageView?
    let repository: ImageRepository

    init(imageView: UIImageView, repository: ImageRepository = ImageRemoteRepository()) {
        self.imageView = imageView
        self.repository = repository
    }

    func downloadImage(for url: String, completion: @escaping () -> Void) {
        repository.fetchImage(for: url) { result in
            guard case let .success(image) = result else { return }
            DispatchQueue.main.async {
                self.imageView?.image = image
            }
        }
    }
}

extension UIImageView {
    var downloader: Downloader {
        return Downloader(imageView: self)
    }
}
