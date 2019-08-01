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
    let thumbnail: Image
    let characters: ListResponse
    let creators: ListResponse

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case description
        case resourceURI
        case type
        case modified
        case thumbnail
        case characters
        case creators
    }
}
