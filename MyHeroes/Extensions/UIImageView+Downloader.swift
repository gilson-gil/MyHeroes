//
//  UIImageView+Downloader.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class Downloader {
    let imageView: UIImageView
    let remoteRepository: ImageRemoteRepository
    private var lastURLKey: Void?

    init(imageView: UIImageView,
         remoteRepository: ImageRemoteRepository = ImageRemoteRepository()) {
        self.imageView = imageView
        self.remoteRepository = remoteRepository
    }

    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    func fetchImage(for urlString: String, completion: @escaping () -> Void) {
        guard let url = URL(string: urlString) else { return }
        setUrl(url)
        CacheManager.shared.image(from: urlString) { [weak self] result in
            guard let image = result?.1 else {
                self?.downloadImage(for: url, completion: completion)
                return
            }
            guard self?.url == url else { return }
            self?.setImage(image)
        }
    }

    private func downloadImage(for url: URL, completion: @escaping () -> Void) {
        remoteRepository.fetchImage(for: url.absoluteString) { [weak self] result in
            guard case let .success(image) = result else { return }
            if let image = image {
                CacheManager.shared.cache(image: image, for: url.absoluteString)
            }
            guard self?.url == url else { return }
            self?.setImage(image)
        }
    }

    private func setUrl(_ url: URL?) {
        objc_setAssociatedObject(imageView, &lastURLKey, url, .OBJC_ASSOCIATION_RETAIN)
    }

    private var url: URL? {
        return objc_getAssociatedObject(imageView, &lastURLKey) as? URL
    }

    deinit {
        print(#function, self)
    }
}

extension UIImageView {
    var downloader: Downloader {
        return Downloader(imageView: self)
    }
}
