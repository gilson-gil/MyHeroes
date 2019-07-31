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
    var viewModel: ListViewModel = .init()

    init(repository: HeroesRepository) {
        self.repository = repository
    }

    func fetchCharacters() {
        repository.fetchList(at: viewModel.characters.count) { [weak viewModel, output] result in
            switch result {
            case .success(let characters):
                guard let viewModel = viewModel else { return }
                viewModel.characters += characters
                output?.charactersFetched(viewModel)
            case .failure(let error):
                output?.charactersFetchFailed(error: error)
            }
        }
    }
}
