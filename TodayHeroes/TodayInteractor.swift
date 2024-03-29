//
//  TodayInteractor.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class TodayInteractor: TodayUseCase {
    weak var output: TodayInteractorOutput?
    let repository: HeroesRepository
    var data: DataContainer<Character>?
    var isFetching: Bool = false

    init(repository: HeroesRepository) {
        self.repository = repository
    }

    func fetchCharacters() {
        guard !isFetching else { return }
        if let count = data?.results.count, count > 0 {
            output?.charactersFetchStarted()
        }
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
}
