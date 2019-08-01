//
//  ImageRemoteRepository.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

struct ImageRemoteRepository: ImageRepository {
    let engine: NetworkEngine<UrlService> = .init()

    func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let target: UrlService = .image(urlString: urlString)
        engine.requestData(target: target) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                let image: UIImage? = UIImage(data: data)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
