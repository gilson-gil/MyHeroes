//
//  HeroesRemoteRepository.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct HeroesRemoteRepository: HeroesRepository {
    let engine: NetworkEngine<HeroesService> = .init()
    let pageSize: Int = 20

    func fetchList(at page: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        let decoder: JSONDecoder = .init()
        let target: HeroesService = .list(pageSize: pageSize, page: page)
        engine.request(target: target, decoder: decoder) { (result: Result<[Character]?, NetworkError>) in
            switch result {
            case .success(let response):
                guard let nonEmpty = response else {
                    return completion(.failure(HeroesRepositoryError.endReached))
                }
                completion(.success(nonEmpty))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
