//
//  Story.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Story: Decodable {
    let identifier: Int
    let title: String
    let description: String
    let resourceURI: String
    let type: String
    let modified: Date
    let thumbnailUrl: String
    let characters: [Character]
    let creators: [Creator]

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case description
        case resourceURI
        case type
        case modified
        case thumbnailUrl = "thumbnail"
        case characters
        case creators
    }
}
