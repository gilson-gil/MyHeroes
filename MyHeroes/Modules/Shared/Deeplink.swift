//
//  Deeplink.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Deeplink {
    let resourceURI: String

    init?(queryItem: URLQueryItem?) {
        guard let queryItem = queryItem else { return nil }
        guard queryItem.name == "resourceURI" else { return nil }
        guard let resourceURI = queryItem.value else { return nil }
        self.resourceURI = resourceURI
    }
}
