//
//  Character.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let identifier: Int
    let name: String
    let description: String
    let modified: Date
    let resourceURI: String
    let thumbnail: Image
    let comics: ListResponse
    let stories: ListResponse
    let events: ListResponse
    let series: ListResponse

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case modified
        case resourceURI
        case thumbnail
        case comics
        case stories
        case events
        case series
    }
}
