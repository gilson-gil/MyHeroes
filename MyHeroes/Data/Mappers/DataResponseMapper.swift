//
//  DataResponseMapper.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

import MyHeroesAPI

struct DataResponseMapper<T: Decodable>: Mapper {
    typealias Model = DataContainer<T>
    typealias Response = DataResponseDTO<T>

    func mapToModel(response: DataResponseDTO<T>) -> DataContainer<T> {
        return .init(offset: response.offset,
                     limit: response.limit,
                     total: response.total,
                     count: response.count,
                     results: response.results)
    }
}
