//
//  HeroesRemoteRepository.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

import MyHeroesAPI

struct HeroesRemoteRepository: HeroesRepository {
    let engine: NetworkEngine<HeroesService> = .init()
    let pageSize: Int = 20

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

    func fetchModel<T: Decodable>(with uri: String, completion: @escaping (Result<HeroesContainer<T>, Error>) -> Void) {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .iso8601
        let target: HeroesService = .uri(url: uri)
        engine.request(target: target, decoder: decoder) { (result: Result<HeroesResponseDTO<T>?, NetworkError>) in
            switch result {
            case .success(let response):
                guard let response = response else {
                    return completion(.failure(HeroesRepositoryError.unknown))
                }
                let mapper: HeroesResponseMapper<T> = .init()
                let mapped = mapper.mapToModel(response: response)
                completion(.success(mapped))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
