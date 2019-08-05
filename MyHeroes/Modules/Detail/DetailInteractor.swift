//
//  DetailInteractor.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class DetailInteractor: DetailUseCase {
    weak var output: DetailInteractorOutput?
    let character: Character
    let repository: HeroesRepository

    var comics: DataContainer<Comic>?
    var events: DataContainer<Event>?
    var stories: DataContainer<Story>?
    var series: DataContainer<Series>?

    init(character: Character, repository: HeroesRepository) {
        self.character = character
        self.repository = repository
    }

    func fetchCharactersDetails() {
        fetchComics()
        fetchEvents()
        fetchStories()
        fetchSeries()
    }

    private func fetchComics() {
        guard let output = output else { return }
        guard character.comics.available > 0 else { return output.characterComicsFetched(.failure(NSError())) }
        output.startedFetchingComics()
        fetch(items: character.comics.items, callback: output.characterComicsFetched)
    }

    private func fetchEvents() {
        guard let output = output else { return }
        guard character.events.available > 0 else { return output.characterEventsFetched(.failure(NSError())) }
        output.startedFetchingEvents()
        fetch(items: character.events.items, callback: output.characterEventsFetched)
    }

    private func fetchStories() {
        guard let output = output else { return }
        guard character.stories.available > 0 else { return output.characterStoriesFetched(.failure(NSError())) }
        output.startedFetchingStories()
        fetch(items: character.stories.items, callback: output.characterStoriesFetched)
    }

    private func fetchSeries() {
        guard let output = output else { return }
        guard character.series.available > 0 else { return output.characterSeriesFetched(.failure(NSError())) }
        output.startedFetchingSeries()
        fetch(items: character.series.items, callback: output.characterSeriesFetched)
    }

    private func fetch<T: Decodable>(items: [ItemResponse], callback: @escaping (Result<[T], Error>) -> Void) {
        let itemsToFetch = items.prefix(3).map { $0 }
        let dispatchGroup: DispatchGroup = .init()
        var resultItems: [T] = []
        for item in itemsToFetch {
            dispatchGroup.enter()
            repository.fetchModel(with: item.resourceURI) { (result: Result<HeroesContainer<T>, Error>) in
                switch result {
                case .success(let response):
                    if let obj = response.data.results.first {
                        resultItems.append(obj)
                    }
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .global()) {
            callback(.success(resultItems))
        }
    }
}
