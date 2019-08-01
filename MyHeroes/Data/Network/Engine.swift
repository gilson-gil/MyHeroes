//
//  Engine.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class NetworkEngine<Target: Service> {
    private var tasks: [URLSessionDataTask] = []

    init() {}

    func request<T: Decodable>(target: Target,
                               decoder: JSONDecoder = JSONDecoder(),
                               completion: @escaping(Result<T?, NetworkError>) -> Void) {
        let requestResult = RequestFactory().create(target: target)
        guard let request = validate(requestResult: requestResult, completion: completion) else { return }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.debug(request: request, response: response, error: error)
            guard self?.handleError(error, completion: completion) == true else { return }

            guard let data = data else { return completion(.success(nil)) }
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.invalidJSON))
            }
        }
        task.resume()
        tasks.append(task)
    }

    func requestData(target: Target,
                     completion: @escaping(Result<Data, NetworkError>) -> Void) {
        let requestResult = RequestFactory().create(target: target)
        guard let request = validate(requestResult: requestResult, completion: completion) else { return }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.debug(request: request, response: response, error: error)
            guard self?.handleError(error, completion: completion) == true else { return }

            completion(.success(data ?? Data()))
        }
        task.resume()
        tasks.append(task)
    }

    private func validate<T>(requestResult: Result<URLRequest, NetworkError>,
                             completion: (Result<T, NetworkError>) -> Void) -> URLRequest? {
        guard case let .success(request) = requestResult else {
            if case let .failure(error) = requestResult {
                completion(.failure(error))
            } else {
                completion(.failure(.unknown))
            }
            return nil
        }
        return request
    }

    private func handleError<T>(_ error: Error?, completion: (Result<T, NetworkError>) -> Void) -> Bool {
        guard let error = error else { return true }
        switch error {
        case is URLError:
            completion(.failure(.noInternet))
        default:
            completion(.failure(.error(error)))
        }
        return false
    }

    private func debug(request: URLRequest, response: URLResponse?, error: Error?) {
        debugPrint("\n--- [REQUEST] \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
        debugPrint("--- [HEADER] \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody, !body.isEmpty {
            debugPrint("--- [BODY] \(String(data: body, encoding: String.Encoding.utf8) ?? "")")
        }
        if let status = (response as? HTTPURLResponse)?.statusCode {
            debugPrint("--- [STATUS] \(status)")
        }
        if let error = error {
            debugPrint("--- [ERROR] \(error.localizedDescription)\n")
        }
    }
}
