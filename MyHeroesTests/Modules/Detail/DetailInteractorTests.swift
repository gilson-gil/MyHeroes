//
//  DetailInteractorTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import MyHeroes

import Nimble
import Quick

final class DetailInteractorOutputMock: DetailInteractorOutput {
    var hasCalledDetailsFetched: Bool = false
    var hasCalledComicsFetched: Bool = false
    var hasCalledEventsFetched: Bool = false
    var hasCalledStoriesFetched: Bool = false
    var hasCalledSeriesFetched: Bool = false

    func startedFetchingComics() {}
    func startedFetchingEvents() {}
    func startedFetchingStories() {}
    func startedFetchingSeries() {}
    func characterDetailsFetched(_ result: Result<Character, Error>) {
        hasCalledDetailsFetched = true
    }
    func characterComicsFetched(_ comics: Result<[Comic], Error>) {
        hasCalledComicsFetched = true
    }
    func characterEventsFetched(_ events: Result<[Event], Error>) {
        hasCalledEventsFetched = true
    }
    func characterStoriesFetched(_ stories: Result<[Story], Error>) {
        hasCalledStoriesFetched = true
    }
    func characterSeriesFetched(_ series: Result<[Series], Error>) {
        hasCalledSeriesFetched = true
    }
    func charactersDetailsFetchFailed(error: Error) {}
}

final class DetailInteractorTests: QuickSpec {
    override func spec() {
        describe("given an interactor") {
            context("when it successfully initializes") {
                let repository: HeroesMockRepository = HeroesMockRepository(type: .regular)
                let character: Character = repository.getMockCharacter()
                let interactor: DetailInteractor = .init(character: character, repository: repository)

                it("should have character and characterURI") {
                    expect(interactor.character).toNot(beNil())
                    expect(interactor.characterURI).toNot(beEmpty())
                }
            }

            context("when fetching details with a character object") {
                let repository: HeroesMockRepository = HeroesMockRepository(type: .regular)
                let character: Character = repository.getMockCharacter()
                let interactor: DetailInteractor = .init(character: character, repository: repository)
                let output = DetailInteractorOutputMock()
                interactor.output = output

                interactor.fetchCharactersDetails()
                it("should eventually have non empty items") {
                    expect(interactor.comics).toEventuallyNot(beEmpty())
                    expect(interactor.events).toEventuallyNot(beEmpty())
                    expect(interactor.stories).toEventuallyNot(beEmpty())
                    expect(interactor.series).toEventuallyNot(beEmpty())
                }

                it("should call output callbacks") {
                    expect(output.hasCalledDetailsFetched).toEventually(beFalse())
                    expect(output.hasCalledComicsFetched).toEventually(beTrue())
                    expect(output.hasCalledEventsFetched).toEventually(beTrue())
                    expect(output.hasCalledStoriesFetched).toEventually(beTrue())
                    expect(output.hasCalledSeriesFetched).toEventually(beTrue())
                }
            }

            context("when fetching details with a characterURI") {
                let repository: HeroesMockRepository = HeroesMockRepository(type: .regular)
                let character: Character = repository.getMockCharacter()
                let interactor: DetailInteractor = .init(characterURI: character.resourceURI, repository: repository)
                let output = DetailInteractorOutputMock()
                interactor.output = output

                interactor.fetchCharactersDetails()
                it("should eventually have non empty items") {
                    expect(interactor.character).toEventuallyNot(beNil())
                    expect(interactor.comics).toEventuallyNot(beEmpty())
                    expect(interactor.events).toEventuallyNot(beEmpty())
                    expect(interactor.stories).toEventuallyNot(beEmpty())
                    expect(interactor.series).toEventuallyNot(beEmpty())
                }

                it("should call output callbacks") {
                    expect(output.hasCalledDetailsFetched).toEventually(beTrue())
                    expect(output.hasCalledComicsFetched).toEventually(beTrue())
                    expect(output.hasCalledEventsFetched).toEventually(beTrue())
                    expect(output.hasCalledStoriesFetched).toEventually(beTrue())
                    expect(output.hasCalledSeriesFetched).toEventually(beTrue())
                }
            }
        }
    }
}

