//
//  HeroesResponseMapper.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

import MyHeroesAPI

struct HeroesResponseMapper<T: Decodable>: Mapper {
    typealias Model = HeroesContainer<T>
    typealias Response = HeroesResponseDTO<T>

    func mapToModel(response: HeroesResponseDTO<T>) -> HeroesContainer<T> {
        let dataMapper: DataResponseMapper<T> = .init()
        let data = dataMapper.mapToModel(response: response.data)
        return .init(data: data)
    }
}
