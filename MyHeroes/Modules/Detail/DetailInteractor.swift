//
//  DetailInteractor.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum DetailInteractorError: Error {
    case emptyResult
}

final class DetailInteractor: DetailUseCase {
    weak var output: DetailInteractorOutput?
    let characterURI: String
    var character: Character?
    let repository: HeroesRepository

    var comics: [Comic] = []
    var events: [Event] = []
    var stories: [Story] = []
    var series: [Series] = []

    convenience init(character: Character, repository: HeroesRepository) {
        self.init(characterURI: character.resourceURI, repository: repository)
        self.character = character
    }

    init(characterURI: String, repository: HeroesRepository) {
        self.characterURI = characterURI
        self.repository = repository
    }

    func fetchCharactersDetails() {
        let dispatchGroup: DispatchGroup = .init()
        if character == nil {
            dispatchGroup.enter()
            fetchCharacterDetails { [weak self] result in
                switch result {
                case .success(let response):
                    self?.character = response
                    self?.output?.characterDetailsFetched(result)
                case .failure(let error):
                    self?.output?.charactersDetailsFetchFailed(error: error)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .global(), execute: fetchItems)
    }

    func fetchItems() {
        fetchComics()
        fetchEvents()
        fetchStories()
        fetchSeries()
    }

    private func fetchComics() {
        guard let output = output else { return }
        guard let character = character else { return }
        guard character.comics.available > 0 else {
            return output.characterComicsFetched(.failure(DetailInteractorError.emptyResult))
        }
        output.startedFetchingComics()
        fetch(items: character.comics.items) { [weak self] (result: Result<[Comic], Error>) in
            if case let .success(comics) = result {
                self?.comics = comics
            }
            output.characterComicsFetched(result)
        }
    }

    private func fetchEvents() {
        guard let output = output else { return }
        guard let character = character else { return }
        guard character.events.available > 0 else {
            return output.characterEventsFetched(.failure(DetailInteractorError.emptyResult))
        }
        output.startedFetchingEvents()
        fetch(items: character.events.items) { [weak self] (result: Result<[Event], Error>) in
            if case let .success(events) = result {
                self?.events = events
            }
            output.characterEventsFetched(result)
        }
    }

    private func fetchStories() {
        guard let output = output else { return }
        guard let character = character else { return }
        guard character.stories.available > 0 else {
            return output.characterStoriesFetched(.failure(DetailInteractorError.emptyResult))
        }
        output.startedFetchingStories()
        fetch(items: character.stories.items) { [weak self] (result: Result<[Story], Error>) in
            if case let .success(stories) = result {
                self?.stories = stories
            }
            output.characterStoriesFetched(result)
        }
    }

    private func fetchSeries() {
        guard let output = output else { return }
        guard let character = character else { return }
        guard character.series.available > 0 else {
            return output.characterSeriesFetched(.failure(DetailInteractorError.emptyResult))
        }
        output.startedFetchingSeries()
        fetch(items: character.series.items) { [weak self] (result: Result<[Series], Error>) in
            if case let .success(series) = result {
                self?.series = series
            }
            output.characterSeriesFetched(result)
        }
    }

    private func fetchCharacterDetails(completion: @escaping (Result<Character, Error>) -> Void) {
        repository.fetchModel(with: characterURI) { (result: Result<HeroesContainer<Character>, Error>) in
            switch result {
            case .success(let response):
                if let character = response.data.results.first {
                    completion(.success(character))
                } else {
                    completion(.failure(DetailInteractorError.emptyResult))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
