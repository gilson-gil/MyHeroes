//
//  AppDelegate.swift
//  MyHeroes
//
//  Created by Gilson Takaasi Gil on 30/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        RootRouter().presentListModule(in: window!)
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }
        guard let deeplink = Deeplink(queryItem: components.queryItems?.first) else { return false }
        let viewController = DetailRouter.startModule(with: deeplink.resourceURI)
        let rootViewController = window?.rootViewController
        rootViewController?.children.last?.navigationItem.backBarButtonItem = .init(title: nil,
                                                                                    style: .plain,
                                                                                    target: nil,
                                                                                    action: nil)
        rootViewController?.show(viewController, sender: nil)
        return true
    }
}
