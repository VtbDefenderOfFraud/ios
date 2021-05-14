//
//  TabBarController.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false

        self.viewControllers = mainControllers
    }
    
    private var mainControllers: [UIViewController] {
        let controller1 = HistoryController()
        controller1.tabBarItem.title = "История кредитов"
        controller1.tabBarItem.image = #imageLiteral(resourceName: "credits")
        
        let controller3 = RequestController()
        controller3.tabBarItem.title = "Запросы"
        controller3.tabBarItem.image = #imageLiteral(resourceName: "requests")
        
        let controller2 = ProfileController()
        controller2.tabBarItem.title = "Профиль"
        controller2.tabBarItem.image = #imageLiteral(resourceName: "user")
        
        return [controller1, controller3, controller2]
    }
}
