//
//  ListContract.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ListView: class {
    var presenter: ListPresentation { get set }

    func showNoContentScreen()
    func showListCharacters(_ viewModel: ListViewModel)
    func showPaginationLoading()
    func hidePaginationLoading()
}

protocol ListPresentation: class {
    var view: ListView? { get set }
    var interactor: ListUseCase { get set }
    var router: ListWireframe { get set }

    func viewWillAppear()
    func requestNextPage()
    func didSelectCharacter(_ character: Character)
}

protocol ListUseCase: class {
    var output: ListInteractorOutput? { get set }

    func fetchCharacters()
}

protocol ListInteractorOutput: class {
    func charactersFetchStarted()
    func charactersFetched(_ dataResponse: DataContainer<Character>)
    func charactersFetchFailed(error: Error)
}

protocol ListWireframe: class {
    var viewController: UIViewController? { get set }

    func presentDetails(for character: Character)

    static func startModule() -> UIViewController
}
