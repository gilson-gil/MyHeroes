//
//  Creator.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Creator: Decodable {
    let identifier: Int
    let firstName: String
    let middleName: String
    let lastName: String
    let suffix: String
    let fullName: String
    let modified: Date
    let resourceURI: String
    let thumbnail: Image

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case firstName
        case middleName
        case lastName
        case suffix
        case fullName
        case modified
        case resourceURI
        case thumbnail
    }
}
