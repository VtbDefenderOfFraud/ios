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
        let controller1 = CreditIndexController()
        controller1.tabBarItem.title = "Кредитный рейтинг"
        controller1.tabBarItem.image = #imageLiteral(resourceName: "credits")
        
        let controller2 = HistoryController()
        controller2.tabBarItem.title = "Кредитная история"
        controller2.tabBarItem.image = #imageLiteral(resourceName: "credits")
        
        let controller3 = InsuredEventsController()
        controller3.tabBarItem.title = "Страховые случаи"
        controller3.tabBarItem.image = #imageLiteral(resourceName: "requests")
        
        let controller4 = ProfileController()
        controller4.tabBarItem.title = "Профиль"
        controller4.tabBarItem.image = #imageLiteral(resourceName: "user")
        
        return [controller1, controller2, controller3, controller4]
    }
}
