//
//  TodayRemoteRepository.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

import MyHeroesAPI

struct TodayRemoteRepository: HeroesRepository {
    let engine: NetworkEngine<HeroesService> = .init()
    let pageSize: Int = 3

    func fetchList(at offset: Int, completion: @escaping (Result<HeroesContainer<Character>, Error>) -> Void) {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .iso8601
        let target: HeroesService = .list(pageSize: pageSize, offset: offset)
        let callback: (Result<HeroesResponseDTO<Character>?, NetworkError>) -> Void = { result in
            switch result {
            case .success(let response):
                guard let response = response, response.data.count > 0 else {
                    return completion(.failure(HeroesRepositoryError.endReached))
                }
                let mapper: HeroesResponseMapper<Character> = .init()
                let mapped = mapper.mapToModel(response: response)
                completion(.success(mapped))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        engine.request(target: target, decoder: decoder, completion: callback)
    }

    func fetchModel<T>(with url: String,
                       completion: @escaping (Result<HeroesContainer<T>, Error>) -> Void) where T: Decodable {}
}
