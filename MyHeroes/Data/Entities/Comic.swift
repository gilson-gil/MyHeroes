//
//  Comic.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let identifier: Int
    let title: String
    let description: String
    let modified: Date
    let format: String
    let pageCount: Int
    let resourceURI: String
    let thumbnail: Image
    let images: [Image]
    let creators: ListResponse
    let characters: ListResponse

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case description
        case modified
        case format
        case pageCount
        case resourceURI
        case thumbnail
        case images
        case creators
        case characters
    }
}
