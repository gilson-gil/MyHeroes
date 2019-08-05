//
//  HeroesContainer.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct HeroesContainer<T: Decodable>: Decodable {
    var data: DataContainer<T>

    init(data: DataContainer<T>) {
        self.data = data
    }
}
