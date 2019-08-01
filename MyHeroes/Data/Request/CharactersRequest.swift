//
//  CharactersRequest.swift
//  MyHeroes
//
//  Created by Gilson Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct CharactersRequest: Encodable {
    let apiKey: String
    let orderBy: String
    let limit: Int
    let offset: Int
    let timestamp: String
    let hash: String

    enum CodingKeys: String, CodingKey {
        case apiKey = "apikey"
        case orderBy
        case limit
        case offset
        case timestamp = "ts"
        case hash
    }

    init(offset: Int, limit: Int, timestamp: String, apiKey: String? = nil, orderBy: String? = nil) {
        self.offset = offset
        self.limit = limit
        self.timestamp = timestamp
        self.apiKey = apiKey ?? Constants.marvelPublicKey.rawValue
        self.orderBy = orderBy ?? "-modified"
        self.hash = "\(timestamp)\(Constants.marvelPrivateKey.rawValue)\(self.apiKey)".md5
    }
}
