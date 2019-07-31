//
//  RootRouter.swift
//  MyHeroes
//
//  Created by Gilson Gil on 31/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class RootRouter: RootWireframe {
    func presentListModule(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = ListRouter.startModule()
    }
}
