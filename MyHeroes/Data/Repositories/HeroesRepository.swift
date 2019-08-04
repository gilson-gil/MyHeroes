//
//  HeroesRepository.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum HeroesRepositoryError: Error {
    case endReached
    case unknown
}

protocol HeroesRepository {
    func fetchList(at page: Int, completion: @escaping (Result<HeroesResponse<Character>, Error>) -> Void)
    func fetchModel<T: Decodable>(with url: String, completion: @escaping (Result<HeroesResponse<T>, Error>) -> Void)
}
