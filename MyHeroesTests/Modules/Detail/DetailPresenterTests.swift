//
//  DetailPresenterTests.swift
//  MyHeroesTests
//
//  Created by Gilson Takaasi Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import MyHeroes

import Nimble
import Quick

final class DetailViewMock: DetailView {
    var presenter: DetailPresentation
    var showDetailsCalled: Bool = false
    var showComicsCalled: Bool = false
    var showEventsCalled: Bool = false
    var showStoriesCalled: Bool = false
    var showSeriesCalled: Bool = false

    init(presenter: DetailPresenter) {
        self.presenter = presenter
    }

    func showDetails(_ character: Character) {
        showDetailsCalled = true
    }
    func showComics(_ comics: DataState<[DetailItemViewModel]>) {
        showComicsCalled = true
    }
    func showEvents(_ events: DataState<[DetailItemViewModel]>) {
        showEventsCalled = true
    }
    func showStories(_ stories: DataState<[DetailItemViewModel]>) {
        showStoriesCalled = true
    }
    func showSeries(_ series: DataState<[DetailItemViewModel]>) {
        showSeriesCalled = true
    }
    func showError(_ error: Error) {}
}

final class DetailPresenterTests: QuickSpec {
    override func spec() {
        describe("given a presenter") {
            context("when it calls view will appear") {
                let router: DetailRouter = .init()
                let repository: HeroesMockRepository = HeroesMockRepository(type: .regular)
                let character: Character = repository.getMockCharacter()
                let interactor: DetailInteractor = .init(character: character, repository: repository)
                let presenter: DetailPresenter = .init(interactor: interactor, router: router)
                let view: DetailViewMock = .init(presenter: presenter)
                presenter.view = view

                let comic: Comic = repository.getMockComic()
                let event: Event = repository.getMockEvent()
                let story: Story = repository.getMockStory()
                let series: Series = repository.getMockSeries()

                presenter.characterDetailsFetched(.success(character))
                presenter.characterComicsFetched(.success([comic]))
                presenter.characterEventsFetched(.success([event]))
                presenter.characterStoriesFetched(.success([story]))
                presenter.characterSeriesFetched(.success([series]))
                it("should") {
                    expect(view.showDetailsCalled).toEventually(beTrue())
                    expect(view.showComicsCalled).toEventually(beTrue())
                    expect(view.showEventsCalled).toEventually(beTrue())
                    expect(view.showStoriesCalled).toEventually(beTrue())
                    expect(view.showSeriesCalled).toEventually(beTrue())
                }
            }
        }
    }
}
