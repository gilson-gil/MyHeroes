//
//  DataState.swift
//  MyHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum DataState<T> {
    case empty
    case loading
    case loaded(data: T)

    var data: T? {
        if case let .loaded(data) = self {
            return data
        } else {
            return nil
        }
    }
}

extension DataState: Equatable {
    static func == (lhs: DataState<T>, rhs: DataState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty), (.loading, .loading), (.loaded, .loaded):
            return true
        default:
            return false
        }
    }
}
