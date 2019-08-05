//
//  TodayPresenter.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class TodayPresenter: TodayPresentation {
    weak var view: TodayView?
    var interactor: TodayUseCase
    var router: TodayWireframe

    init(interactor: TodayUseCase, router: TodayWireframe) {
        self.interactor = interactor
        self.router = router
    }

    func didRequestUpdate() {
        interactor.fetchCharacters()
    }

    func didSelectCharacter(_ character: Character) {
        router.presentDetails(for: character)
    }
}

extension TodayPresenter: TodayInteractorOutput {
    func charactersFetchStarted() {}

    func charactersFetched(_ dataResponse: DataContainer<Character>) {
        let viewModel: TodayViewModel = .init()
        viewModel.characters = dataResponse.results
        if dataResponse.results.isEmpty {
            view?.showNoContentScreen()
        } else {
            view?.showListCharacters(viewModel)
        }
    }

    func charactersFetchFailed(error: Error) {
        view?.showNoContentScreen()
    }
}
