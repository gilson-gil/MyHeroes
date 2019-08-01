//
//  CacheManager.swift
//  MyHeroes
//
//  Created by Gilson Gil on 01/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class CacheManager {
    static let shared: CacheManager = .init()

    private let cache = NSCache<NSString, UIImage>()

    func image(from urlString: String, completion: @escaping ((String, UIImage)?) -> Void) {
        // memmory cache
        if let cached = cache.object(forKey: urlString as NSString) {
            return completion((urlString, cached))
        }

        // disk cache
        if let disked = getFile(with: urlString), let image = UIImage(data: disked) {
            cache.setObject(image, forKey: urlString as NSString)
            return completion((urlString, image))
        }

        completion(nil)
    }

    func cache(image: UIImage, for urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
        if let data = image.pngData() {
            createFile(urlString, contents: data)
        }
    }

    func getFile(with urlString: String) -> Data? {
        let manager = FileManager.default
        let filename = urlString.components(separatedBy: "/").last ?? urlString
        let path = NSTemporaryDirectory().appending(filename)
        return manager.contents(atPath: path)
    }

    func createFile(_ urlString: String, contents: Data) {
        let manager = FileManager.default
        let filename = urlString.components(separatedBy: "/").last ?? urlString
        let path = NSTemporaryDirectory().appending(filename)
        manager.createFile(atPath: path, contents: contents, attributes: nil)
    }
}
