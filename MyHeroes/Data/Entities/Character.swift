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
    let thumbnailUrl: String
    let comics: [Comic]
    let stories: [Story]
    let events: [Event]
    let series: [Series]

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case modified
        case resourceURI
        case thumbnailUrl = "thumbnail"
        case comics
        case stories
        case events
        case series
    }
}
