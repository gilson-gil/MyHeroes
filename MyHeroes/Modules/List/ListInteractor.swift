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
    var data: DataResponse<Character>?

    init(repository: HeroesRepository) {
        self.repository = repository
    }

    func fetchCharacters() {
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
        }
    }
}
