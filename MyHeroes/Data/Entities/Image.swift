//
//  Image.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Image: Decodable {
    let path: String
    let `extension`: String?

    var fullUrl: String {
        guard var url = URL(string: path) else { return "" }
        if let `extension` = `extension` {
            url.appendPathExtension(`extension`)
        }
        return url.absoluteString
    }
}
