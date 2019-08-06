//
//  ListInteractorTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import MyHeroes

import Nimble
import Quick

final class ListInteractorTests: QuickSpec {
    override func spec() {
        describe("given an interactor") {
            context("when it successfully initializes") {
                let repository: HeroesRepository = HeroesMockRepository(type: .regular)
                let interactor: ListInteractor = .init(repository: repository)

                it("should have nil data and should not be fetching and has not reached end yet") {
                    expect(interactor.data).to(beNil())
                    expect(interactor.hasReachedEnd()).to(beFalse())
                    expect(interactor.isFetching).to(beFalse())
                }
            }

            context("when fetching last page") {
                let repository: HeroesRepository = HeroesMockRepository(type: .lastPage)
                let interactor: ListInteractor = .init(repository: repository)

                interactor.fetchCharacters()
                it("should eventually have data and hasReachedEnd true") {
                    expect(interactor.data).toEventuallyNot(beNil())
                    expect(interactor.data?.count).toEventually(equal(1492))
                    expect(interactor.hasReachedEnd()).toEventually(beTrue())
                }
            }

            context("when fetching last page") {
                let repository: HeroesRepository = HeroesMockRepository(type: .error)
                let interactor: ListInteractor = .init(repository: repository)

                interactor.fetchCharacters()
                it("should eventually have data and hasReachedEnd true") {
                    expect(interactor.data).toEventuallyNot(beNil())
                    expect(interactor.data?.count).toEventually(equal(0))
                    expect(interactor.hasReachedEnd()).toEventually(beTrue())
                }
            }
        }
    }
}
