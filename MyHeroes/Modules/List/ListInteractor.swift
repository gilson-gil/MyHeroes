//
//  ListInteractor.swift
//  MyHeroes
//
//  Created by Gilson Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class ListInteractor: ListUseCase {
    weak var output: ListInteractorOutput?
    let repository: HeroesRepository
    var data: DataContainer<Character>?
    var isFetching: Bool = false

    init(repository: HeroesRepository) {
        self.repository = repository
    }

    func resetFetch() {
        isFetching = false
        data = nil
        fetchCharacters()
    }

    func fetchCharacters() {
        guard !isFetching && !hasReachedEnd() else { return }
        output?.charactersFetchStarted()
        isFetching = true
        repository.fetchList(at: data?.results.count ?? 0) { [weak self] result in
            switch result {
            case .success(let response):
                response.data.results = (self?.data?.results ?? []) + response.data.results
                self?.data = response.data
                self?.output?.charactersFetched(response.data)

            case .failure(let error):
                switch error {
                case HeroesRepositoryError.endReached:
                    break
                default:
                    self?.output?.charactersFetchFailed(error: error)
                }
            }
            self?.isFetching = false
        }
    }

    func hasReachedEnd() -> Bool {
        guard let data = data else { return false }
        return data.offset + data.count >= data.total
    }
}
