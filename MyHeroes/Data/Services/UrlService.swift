//
//  UrlService.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum UrlService {
    case image(urlString: String)
}

extension UrlService: Service {
    var baseURL: URL? {
        return nil
    }

    var path: String {
        return ""
    }

    var absoluteURL: URL? {
        switch self {
        case .image(let urlString):
            return URL(string: urlString)
        }
    }

    var method: Method {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }
}
