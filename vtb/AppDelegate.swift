//
//  AppDelegate.swift
//  vtb
//
//  Created by Alina Golubeva on 19.04.2021.
//

import UIKit
import Firebase

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        showRoot()
        
        return true
    }

    
    func showRoot() {
        let navigation = UINavigationController(rootViewController: TabBarController())
        self.window?.rootViewController = AppData.isRegistered ? navigation : LoginController()
        self.window?.makeKeyAndVisible()
    }


}

