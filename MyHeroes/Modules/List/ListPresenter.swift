//
//  ListPresenter.swift
//  MyHeroes
//
//  Created by Gilson Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class ListPresenter: ListPresentation {
    weak var view: ListView?
    var interactor: ListUseCase
    var router: ListWireframe

    init(interactor: ListUseCase, router: ListWireframe) {
        self.interactor = interactor
        self.router = router
    }

    func requestFirstPage() {
        view?.showLoading()
        interactor.resetFetch()
    }

    func requestNextPage() {
        interactor.fetchCharacters()
    }

    func didSelectCharacter(_ character: Character) {
        router.presentDetails(for: character)
    }
}

extension ListPresenter: ListInteractorOutput {
    func charactersFetchStarted() {
        view?.showPaginationLoading()
    }

    func charactersFetched(_ dataResponse: DataContainer<Character>) {
        let viewModel: ListViewModel = .init()
        viewModel.characters = dataResponse.results
        viewModel.hasNextPage = dataResponse.results.count == dataResponse.count
        view?.showListCharacters(viewModel)
        view?.hidePaginationLoading()
    }

    func charactersFetchFailed(error: Error) {
        view?.showError(error)
        view?.hidePaginationLoading()
    }
}
