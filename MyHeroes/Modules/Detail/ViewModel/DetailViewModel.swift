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
    var character: Character?
    var comics: DataState<[DetailItemViewModel]> = .empty {
        didSet {
            update(index: DetailSectionType.comics.rawValue, dataState: comics)
        }
    }
    var events: DataState<[DetailItemViewModel]> = .empty {
        didSet {
            update(index: DetailSectionType.events.rawValue, dataState: events)
        }
    }
    var stories: DataState<[DetailItemViewModel]> = .empty {
        didSet {
            update(index: DetailSectionType.stories.rawValue, dataState: stories)
        }
    }
    var series: DataState<[DetailItemViewModel]> = .empty {
        didSet {
            update(index: DetailSectionType.series.rawValue, dataState: series)
        }
    }
    var configurators: [DetailSectionType.RawValue: [ViewConfiguratorType]]
    var headerConfigurators: [DetailSectionType.RawValue: ViewConfiguratorType?]
    var imageTextViewModel: ImageTextViewModel {
        return .init(text: character?.name, imageUrl: character?.thumbnail.fullUrl)
    }
    var hasLoadedAllItems: Bool {
        return comics != .loading && events != .loading && stories != .loading && series != .loading
    }

    init(character: Character?) {
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

    private func update(index: Int, dataState: DataState<[DetailItemViewModel]>) {
        switch dataState {
        case .empty:
            configurators[index] = [
                ViewConfigurator<DetailItemCell>(viewModel: DetailItemViewModel(imageUrl: nil,
                                                                                title: "Não há items para mostrar",
                                                                                description: nil))
            ]
        case .loading:
            configurators[index] = [
                ViewConfigurator<LoadingCollectionViewCell>(viewModel: nil)
            ]
        case .loaded(let data):
            configurators[index] = data.compactMap(createConfigurators)
        }
    }
}
