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

    static func startModule() -> UIViewController {
        let router: ListRouter = .init()
        let repository: HeroesRemoteRepository = .init()
        let interactor: ListInteractor = .init(repository: repository)
        let presenter: ListPresenter = .init(interactor: interactor, router: router)
        let view: ListViewController = .init(presenter: presenter)

        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.barTintColor = .marvelRed
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        view.presenter = presenter
        presenter.view = view
        interactor.output = presenter
        router.viewController = view

        return navigation
    }

    func presentDetails(for character: Character) {
        let viewController = DetailRouter.startModule(for: character)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
        self.viewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil,
                                                                                style: .plain,
                                                                                target: nil,
                                                                                action: nil)
    }
}
