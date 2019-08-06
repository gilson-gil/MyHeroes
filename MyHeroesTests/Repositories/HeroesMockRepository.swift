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
        let fileName: String
        if uri.contains("character") {
            fileName = "ValidCharacterMock"
        } else if uri.contains("comics") {
            fileName = "ValidComicMock"
        } else if uri.contains("events") {
            fileName = "ValidEventMock"
        } else if uri.contains("stories") {
            fileName = "ValidStoryMock"
        } else if uri.contains("series") {
            fileName = "ValidSeriesMock"
        } else {
            fileName = ""
        }
        let file = Bundle(for: ListViewModelTests.self).url(forResource: fileName, withExtension: "json")!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(HeroesContainer<T>.self, from: data)
        completion(.success(json))
    }

    func getMockCharacter() -> Character {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let file = Bundle(for: ListViewModelTests.self).url(forResource: "ValidCharactersListMock", withExtension: "json")!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(HeroesContainer<Character>.self, from: data)
        let character = json.data.results[0]
        return character
    }
}
