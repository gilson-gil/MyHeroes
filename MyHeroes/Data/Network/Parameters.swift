//
//  Parameters.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

extension Parameters {
    var queryEncoded: [URLQueryItem] {
        return map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
    }
}

extension Encodable {
    var parameters: Parameters? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let parameters = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters
        return parameters
    }
}
