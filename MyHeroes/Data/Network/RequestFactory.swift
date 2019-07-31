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
                baseUrl: URL,
                path: String,
                parameters: Parameters? = nil) -> Result<URLRequest, NetworkError> {
        guard var urlComponents: URLComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            return .failure(.invalidURL)
        }
        urlComponents.path = path
        urlComponents.queryItems = parameters?.queryEncoded

        guard let url: URL = urlComponents.url else { return .failure(.invalidURL) }
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return .success(urlRequest)
    }

    func create<Target: Service>(target: Target) -> Result<URLRequest, NetworkError> {
        return create(method: target.method,
                      baseUrl: target.baseURL,
                      path: target.path,
                      parameters: target.parameters)
    }
}
