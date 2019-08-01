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

    func fetchList(at offset: Int, completion: @escaping (Result<HeroesResponse<Character>, Error>) -> Void) {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .iso8601
        let target: HeroesService = .list(pageSize: pageSize, offset: offset)
        engine.request(target: target, decoder: decoder) { (result: Result<HeroesResponse<Character>?, NetworkError>) in
            switch result {
            case .success(let response):
                guard let response = response, response.data.count > 0 else {
                    return completion(.failure(HeroesRepositoryError.endReached))
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
