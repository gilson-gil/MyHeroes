//
//  Event.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Event: Decodable {
    let identifier: Int
    let title: String
    let description: String?
    let resourceURI: String
    let modified: Date
    let thumbnail: Image?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case description
        case resourceURI
        case modified
        case thumbnail
    }
}

extension Event: TitleDescriptionThumbnailProtocol {}
