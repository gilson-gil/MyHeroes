//
//  DetailViewModel.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum DetailSectionType: Int, CaseIterable {
    case comics = 0
    case events
    case stories
    case series

    var title: String {
        switch self {
        case .comics:
            return "Comics"
        case .events:
            return "Events"
        case .stories:
            return "Stories"
        case .series:
            return "Series"
        }
    }
}

final class DetailViewModel {
    var character: Character
    var comics: [DetailItemViewModel] = [] {
        didSet {
            configurators[DetailSectionType.comics.rawValue] = comics.map(createConfigurators)
        }
    }
    var events: [DetailItemViewModel] = [] {
        didSet {
            configurators[DetailSectionType.events.rawValue] = events.map(createConfigurators)
        }
    }
    var stories: [DetailItemViewModel] = [] {
        didSet {
            configurators[DetailSectionType.stories.rawValue] = stories.map(createConfigurators)
        }
    }
    var series: [DetailItemViewModel] = [] {
        didSet {
            configurators[DetailSectionType.series.rawValue] = series.map(createConfigurators)
        }
    }
    var configurators: [DetailSectionType.RawValue: [ViewConfiguratorType]]
    var headerConfigurators: [DetailSectionType.RawValue: ViewConfiguratorType?]
    var imageTextViewModel: ImageTextViewModel {
        return .init(text: character.name, imageUrl: character.thumbnail.fullUrl)
    }

    init(character: Character) {
        self.character = character
        self.configurators = DetailSectionType.allCases.reduce([:]) { result, new in
            var dict = result
            dict[new.rawValue] = []
            return dict
        }
        self.headerConfigurators = DetailSectionType.allCases.reduce([:]) { result, new in
            var dict = result
            dict[new.rawValue] = ViewConfigurator<DetailHeader>(viewModel: new.title)
            return dict
        }
    }

    private func createConfigurators(from viewModel: DetailItemViewModel) -> ViewConfiguratorType {
        return ViewConfigurator<DetailItemCell>(viewModel: viewModel)
    }
}
