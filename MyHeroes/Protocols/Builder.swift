//
//  Builder.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

protocol Builder {
    associatedtype AnyType

    func build() -> AnyType
}
