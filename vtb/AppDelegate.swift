//
//  AppDelegate.swift
//  vtb
//
//  Created by Alina Golubeva on 19.04.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        showRoot()
        
        return true
    }

    
    func showRoot() {
        let navigation = UINavigationController(rootViewController: LoginController())
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }


}

