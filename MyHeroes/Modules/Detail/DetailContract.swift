//
//  DetailContract.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol DetailView: class {
    var presenter: DetailPresentation { get set }

    func showDetails(_ character: Character)
    func showComics(_ comics: DataState<[DetailItemViewModel]>)
    func showEvents(_ events: DataState<[DetailItemViewModel]>)
    func showStories(_ stories: DataState<[DetailItemViewModel]>)
    func showSeries(_ series: DataState<[DetailItemViewModel]>)
    func showError(_ error: Error)
}

protocol DetailPresentation: class {
    var view: DetailView? { get set }
    var interactor: DetailUseCase { get set }
    var router: DetailWireframe { get set }

    func viewWillAppear()
}

protocol DetailUseCase: class {
    var output: DetailInteractorOutput? { get set }

    func fetchCharactersDetails()
}

protocol DetailInteractorOutput: class {
    func startedFetchingComics()
    func startedFetchingEvents()
    func startedFetchingStories()
    func startedFetchingSeries()
    func characterDetailsFetched(_ result: Result<Character, Error>)
    func characterComicsFetched(_ comics: Result<[Comic], Error>)
    func characterEventsFetched(_ events: Result<[Event], Error>)
    func characterStoriesFetched(_ stories: Result<[Story], Error>)
    func characterSeriesFetched(_ series: Result<[Series], Error>)
    func charactersDetailsFetchFailed(error: Error)
}

protocol DetailWireframe: class {
    var viewController: UIViewController? { get set }

    static func startModule(for character: Character) -> UIViewController
    static func startModule(with characterURI: String) -> UIViewController
}
