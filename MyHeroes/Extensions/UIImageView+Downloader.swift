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
    let remoteRepository: ImageRemoteRepository

    init(imageView: UIImageView,
         remoteRepository: ImageRemoteRepository = ImageRemoteRepository()) {
        self.imageView = imageView
        self.remoteRepository = remoteRepository
    }

    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView?.image = image
        }
    }

    func fetchImage(for urlString: String, completion: @escaping () -> Void) {
        CacheManager.shared.image(from: urlString) { result in
            guard let image = result?.1 else {
                return self.downloadImage(for: urlString, completion: completion)
            }
            self.setImage(image)
        }
    }

    func downloadImage(for urlString: String, completion: @escaping () -> Void) {
        remoteRepository.fetchImage(for: urlString) { result in
            guard case let .success(image) = result else { return }
            self.setImage(image)
            if let image = image {
                CacheManager.shared.cache(image: image, for: urlString)
            }
        }
    }
}

extension UIImageView {
    var downloader: Downloader {
        return Downloader(imageView: self)
    }
}
