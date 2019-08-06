//
//  HeroesMockRepository.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import MyHeroes

import Foundation

enum MockType {
    case regular, lastPage, error

    var listFile: String {
        switch self {
        case .regular:
            return "ValidCharactersListMock"
        case .lastPage:
            return "ValidLastPageCharactersListMock"
        case .error:
            return "ErrorCharactersListMock"
        }
    }
}

struct HeroesMockRepository: HeroesRepository {
    let type: MockType

    func fetchList(at offset: Int, completion: @escaping (Result<HeroesContainer<Character>, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let file = Bundle(for: ListViewModelTests.self).url(forResource: type.listFile, withExtension: "json")!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(HeroesContainer<Character>.self, from: data)
        sleep(2)
        completion(.success(json))
    }

    func fetchModel<T: Decodable>(with uri: String, completion: @escaping (Result<HeroesContainer<T>, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let file = Bundle(for: ListViewModelTests.self).url(forResource: "ValidComicMock", withExtension: "json")!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(HeroesContainer<T>.self, from: data)
        sleep(2)
        completion(.success(json))
    }
}
