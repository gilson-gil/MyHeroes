//
//  ListViewModel.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class ListViewModel {
    var configurators: [ViewConfiguratorType] = []
    var characters: [Character] = [] {
        didSet {
            configurators = characters.map {
                ViewConfigurator<ListItemCell>(viewModel: ListItemViewModel(title: $0.name, imageUrl: $0.thumbnailUrl))
            }
        }
    }
}
