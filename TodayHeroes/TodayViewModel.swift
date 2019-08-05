//
//  TodayViewModel.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class TodayViewModel {
    var characters: [Character] = [] {
        didSet {
            configurators = characters.map {
                ViewConfigurator<TodayItemCell>(viewModel: TodayItemViewModel(title: $0.name,
                                                                              imageUrl: $0.thumbnail.fullUrl))
            }
        }
    }
    var configurators: [ViewConfiguratorType] = []
}
