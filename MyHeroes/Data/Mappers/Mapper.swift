//
//  Mapper.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype Model
    associatedtype Response

    func mapToModel(response: Response) -> Model
    func mapFromModel(model: Model) -> Response?
}

extension Mapper {
    func mapFromModel(model: Model) -> Response? {
        return nil
    }
}
