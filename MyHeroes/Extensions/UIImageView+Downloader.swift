//
//  UIImageView+Downloader.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class Downloader {
    let remoteRepository: ImageRemoteRepository
    var currentUrlString: String?

    init(remoteRepository: ImageRemoteRepository = ImageRemoteRepository()) {
        self.remoteRepository = remoteRepository
    }

    func fetchImage(for urlString: String, completion: @escaping (UIImage?) -> Void) {
        currentUrlString = urlString
        CacheManager.shared.image(from: urlString) { result in
            guard let image = result?.1 else {
                return self.downloadImage(for: urlString, completion: completion)
            }
            completion(image)
        }
    }

    private func downloadImage(for urlString: String, completion: @escaping (UIImage?) -> Void) {
        remoteRepository.fetchImage(for: urlString) { result in
            guard self.currentUrlString == urlString else { return completion(nil) }
            guard case let .success(image) = result else { return completion(nil) }
            if let image = image {
                CacheManager.shared.cache(image: image, for: urlString)
            }
            completion(image)
        }
    }
}
