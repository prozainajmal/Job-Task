//
//  AppDelegate.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigatioControoler = UINavigationController(rootViewController: HomeController())
        window.rootViewController = navigatioControoler
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

   

}

