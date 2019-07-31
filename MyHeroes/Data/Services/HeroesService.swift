//
//  HeroesService.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum HeroesService {
    case list(pageSize: Int, page: Int)
}

extension HeroesService: Service {
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com")!
    }

    var path: String {
        switch self {
        case .list:
            return "/v1/public/characters"
        }
    }

    var method: Method {
        return .get
    }

    var parameters: Parameters? {
        switch self {
        case .list(let pageSize, let page):
            return CharactersRequest(offset: page * pageSize, limit: pageSize, timestamp: UUID().uuidString).parameters
        }
    }
}
