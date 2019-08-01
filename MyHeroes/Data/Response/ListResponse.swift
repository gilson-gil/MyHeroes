//
//  ListResponse.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct ListResponse: Decodable {
    let available: Int
    let items: [ItemResponse]
}
