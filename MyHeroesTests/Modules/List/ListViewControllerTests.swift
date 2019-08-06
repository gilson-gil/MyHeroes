//
//  ListViewControllerTests.swift
//  MyHeroesTests
//
//  Created by Gilson Gil on 06/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import MyHeroes

import Nimble
import Quick

final class ListViewControllerTests: QuickSpec {
    override func spec() {
        describe("given a list view controller") {
            let router: ListRouter = .init()
            let repository: HeroesRepository = HeroesMockRepository(type: .regular)
            let interactor: ListInteractor = .init(repository: repository)
            let presenter: ListPresenter = .init(interactor: interactor, router: router)

            context("when loaded with a view model") {
                let viewController: ListViewController = ListViewController(presenter: presenter)
                let viewModel: ListViewModel = .init()
                viewModel.characters = (0..<7).map {
                    .init(identifier: 0,
                          name: "Nome \($0)",
                          description: "",
                          modified: Date(),
                          resourceURI: "",
                          thumbnail: Image(path: "", extension: nil),
                          comics: ListResponse(available: 0, items: []),
                          stories: ListResponse(available: 0, items: []),
                          events: ListResponse(available: 0, items: []),
                          series: ListResponse(available: 0, items: []))
                }
                viewController.showListCharacters(viewModel)
                it("should display the correct data amount") {
                    expect(viewController.collectionView.numberOfItems(inSection: 0)).toEventually(equal(7))
                }
            }

            context("when loaded with a empty view model") {
                let viewController: ListViewController = ListViewController(presenter: presenter)
                viewController.showNoContentScreen()
                it("should display the correct data amount") {
                    expect(viewController.collectionView.numberOfItems(inSection: 0)).toEventually(equal(0))
                    expect(viewController.collectionView.backgroundView).to(beAKindOf(UILabel.self))
                }
            }
        }
    }
}
