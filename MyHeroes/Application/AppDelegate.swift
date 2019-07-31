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
}
