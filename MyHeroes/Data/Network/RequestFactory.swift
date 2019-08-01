//
//  RequestFactory.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct RequestFactory {
    func create(method: Method,
                url: URL,
                path: String,
                parameters: Parameters? = nil) -> Result<URLRequest, NetworkError> {
        guard var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return .failure(.invalidURL)
        }
        urlComponents.queryItems = parameters?.queryEncoded

        guard let url: URL = urlComponents.url else { return .failure(.invalidURL) }
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return .success(urlRequest)
    }

    func create<Target: Service>(target: Target) -> Result<URLRequest, NetworkError> {
        guard let absoluteURL = target.absoluteURL else { return .failure(.invalidURL) }
        return create(method: target.method,
                      url: absoluteURL,
                      path: target.path,
                      parameters: target.parameters)
    }
}
