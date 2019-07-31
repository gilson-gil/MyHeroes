//
//  Series.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Series: Decodable {
    let identifier: Int
    let title: String
    let description: String
    let resourceURI: String
    let startYear: Int
    let endYear: Int
    let rating: String
    let modified: Date
    let thumbnailUrl: String
    let characters: [Character]
    let creators: [Creator]
}
