//
//  TodayContract.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol TodayView: class {
    var router: TodayWireframe? { get set }
    var presenter: TodayPresentation? { get set }

    func showNoContentScreen()
    func showListCharacters(_ viewModel: TodayViewModel)
}

protocol TodayPresentation: class {
    var view: TodayView? { get set }
    var interactor: TodayUseCase { get set }
    var router: TodayWireframe { get set }

    func didRequestUpdate()
    func didSelectCharacter(_ character: Character)
}

protocol TodayUseCase: class {
    var output: TodayInteractorOutput? { get set }

    func fetchCharacters()
}

protocol TodayInteractorOutput: class {
    func charactersFetchStarted()
    func charactersFetched(_ dataResponse: DataContainer<Character>)
    func charactersFetchFailed(error: Error)
}

protocol TodayWireframe: class {
    var viewController: UIViewController? { get set }

    func presentDetails(for character: Character)

    static func startModule(from viewController: TodayViewController) -> UIViewController
}
