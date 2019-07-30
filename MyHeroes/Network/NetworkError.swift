//
//  NetworkError.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case noInternet
    case invalidURL
    case invalidJSON
    case error(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Parece que você está sem internet, tente novamente mais tarde"
        case .invalidURL:
            return "URL inválida"
        case .invalidJSON:
            return "JSON inválido"
        case .error(let error):
            return error.localizedDescription
        case .unknown:
            return "Erro desconhecido"
        }
    }
}
