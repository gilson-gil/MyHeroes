//
//  HeroesService.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum HeroesService {
    case list(pageSize: Int, offset: Int)
    case uri(url: String)
}

extension HeroesService: Service {
    var baseURL: URL? {
        switch self {
        case .uri:
            return nil
        default:
            return URL(string: "https://gateway.marvel.com")
        }
    }

    var path: String {
        switch self {
        case .list:
            return "/v1/public/characters"
        case .uri:
            return ""
        }
    }

    var absoluteURL: URL? {
        switch self {
        case .list:
            return baseURL?.appendingPathComponent(path)
        case .uri(let url):
            return URL(string: url)
        }
    }

    var method: Method {
        return .get
    }

    var parameters: Parameters? {
        var parameters: Parameters?
        switch self {
        case .list(let pageSize, let offset):
            parameters = CharactersRequest(offset: offset, limit: pageSize).parameters
        case .uri:
            parameters = [:]
        }
        if let authorizationParameters = AuthorizationParameters().parameters {
            parameters?.merge(authorizationParameters) { lhs, _ in lhs }
        }
        return parameters
    }
}
