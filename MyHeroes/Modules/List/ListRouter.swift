//
//  ListRouter.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ListRouter: ListWireframe {
    weak var viewController: UIViewController?

    func presentDetails(for character: Character) {
//        let detailsModuleViewController = DetailsRouter.assembleModule(article)
//        viewController?.navigationController?.pushViewController(detailsModuleViewController, animated: true)
    }

    static func startModule() -> UIViewController {
        let router: ListRouter = .init()
        let repository: HeroesRemoteRepository = .init()
        let interactor: ListInteractor = .init(repository: repository)
        let presenter: ListPresenter = .init(interactor: interactor, router: router)
        let view: ListViewController = .init(presenter: presenter)

        let navigation = UINavigationController(rootViewController: view)

        view.presenter = presenter
        presenter.view = view
        interactor.output = presenter
        router.viewController = view

        return navigation
    }
}
