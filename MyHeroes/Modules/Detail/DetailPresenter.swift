//
//  DetailPresenter.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class DetailPresenter: DetailPresentation {
    weak var view: DetailView?
    var interactor: DetailUseCase
    var router: DetailWireframe

    init(interactor: DetailUseCase, router: DetailWireframe) {
        self.interactor = interactor
        self.router = router
    }

    func viewWillAppear() {
        interactor.fetchCharactersDetails()
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func startedFetchingComics() {
        view?.showComics(.loading)
    }

    func startedFetchingEvents() {
        view?.showEvents(.loading)
    }

    func startedFetchingStories() {
        view?.showStories(.loading)
    }

    func startedFetchingSeries() {
        view?.showSeries(.loading)
    }

    func characterDetailsFetched(_ result: Result<Character, Error>) {
        switch result {
        case .success(let character):
            view?.showDetails(character)
        case .failure(let error):
            view?.showError(error)
        }
    }

    func characterComicsFetched(_ comics: Result<[Comic], Error>) {
        switch comics {
        case .success(let comics):
            if comics.isEmpty {
                view?.showComics(.empty)
            } else {
                let viewModels = comics
                    .sorted(by: { $0.modified <= $1.modified })
                    .map(createViewModel)
                view?.showComics(.loaded(data: viewModels))
            }
        case .failure(let error):
            print(error)
        }
    }

    func characterEventsFetched(_ events: Result<[Event], Error>) {
        switch events {
        case .success(let events):
            if events.isEmpty {
                view?.showEvents(.empty)
            } else {
                let viewModels = events
                    .sorted(by: { $0.modified <= $1.modified })
                    .map(createViewModel)
                view?.showEvents(.loaded(data: viewModels))
            }
        case .failure(let error):
            print(error)
        }
    }

    func characterStoriesFetched(_ stories: Result<[Story], Error>) {
        switch stories {
        case .success(let stories):
            if stories.isEmpty {
                view?.showStories(.empty)
            } else {
                let viewModels = stories
                    .sorted(by: { $0.modified <= $1.modified })
                    .map(createViewModel)
                view?.showStories(.loaded(data: viewModels))
            }
        case .failure(let error):
            print(error)
        }
    }

    func characterSeriesFetched(_ series: Result<[Series], Error>) {
        switch series {
        case .success(let series):
            if series.isEmpty {
                view?.showSeries(.empty)
            } else {
                let viewModels = series
                    .sorted(by: { $0.modified <= $1.modified })
                    .map(createViewModel)
                view?.showSeries(.loaded(data: viewModels))
            }
        case .failure(let error):
            print(error)
        }
    }

    func charactersDetailsFetchFailed(error: Error) {
        view?.showError(error)
    }

    private func createViewModel(from model: TitleDescriptionThumbnailProtocol) -> DetailItemViewModel {
        return DetailItemViewModel(imageUrl: model.thumbnail?.fullUrl,
                                   title: model.title,
                                   description: model.description)
    }
}
