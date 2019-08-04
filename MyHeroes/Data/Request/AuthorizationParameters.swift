//
//  AuthorizationParameters.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct AuthorizationParameters: Encodable {
    let apiKey: String = Constants.marvelPublicKey.rawValue
    let timestamp: String = UUID().uuidString
    let hash: String

    init() {
        hash = (timestamp + Constants.marvelPrivateKey.rawValue + apiKey).md5
    }

    enum CodingKeys: String, CodingKey {
        case apiKey = "apikey"
        case timestamp = "ts"
        case hash
    }
}
