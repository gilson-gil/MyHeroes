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

    func viewWillAppear() {
        interactor.fetchCharacters()
    }

    func didSelectCharacter(_ character: Character) {
        router.presentDetails(for: character)
    }
}

extension ListPresenter: ListInteractorOutput {
    func charactersFetched(_ dataResponse: DataResponse<Character>) {
        let viewModel: ListViewModel = .init()
        viewModel.characters = dataResponse.results
        view?.showListCharacters(viewModel)
    }

    func charactersFetchFailed(error: Error) {
        print(error)
    }
}
