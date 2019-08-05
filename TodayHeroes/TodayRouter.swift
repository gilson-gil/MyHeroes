//
//  TodayRouter.swift
//  TodayHeroes
//
//  Created by Gilson Gil on 04/08/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class TodayRouter: TodayWireframe {
    weak var viewController: UIViewController?

    static func startModule(from viewController: TodayViewController) -> UIViewController {
        let view = viewController as TodayView
        let router: TodayRouter = .init()
        let repository: TodayRemoteRepository = .init()
        let interactor: TodayInteractor = .init(repository: repository)
        let presenter: TodayPresenter = .init(interactor: interactor, router: router)

        view.presenter = presenter
        presenter.view = view
        interactor.output = presenter
        router.viewController = viewController

        return viewController
    }

    func presentDetails(for character: Character) {
        let urlString = Constants.appUrlScheme.rawValue
            + "://" + Constants.urlPath.rawValue
            + "?" + Constants.uriQueryName.rawValue
            + "=" + character.resourceURI
        guard let url = URL(string: urlString) else { return }
        viewController?.extensionContext?.open(url, completionHandler: nil)
    }
}
