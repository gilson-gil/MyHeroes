//
//  DetailRouter.swift
//  MyHeroes
//
//  Created by Gilson Gil on 03/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class DetailRouter: DetailWireframe {
    weak var viewController: UIViewController?

    static func startModule(for character: Character) -> UIViewController {
        let router: DetailRouter = .init()
        let repository: HeroesRemoteRepository = .init()
        let interactor: DetailInteractor = .init(character: character, repository: repository)
        let presenter: DetailPresenter = .init(interactor: interactor, router: router)
        let viewModel: DetailViewModel = .init(character: character)
        let view: DetailViewController = .init(presenter: presenter, viewModel: viewModel)

        view.presenter = presenter
        presenter.view = view
        interactor.output = presenter
        router.viewController = view

        return view
    }
}
