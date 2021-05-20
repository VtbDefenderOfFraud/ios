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
        
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: NSNotification.Name(rawValue: "insure"), object: nil)
    }
    
    @objc
    private func change() {
        selectedIndex = 2
    }
    
    private var mainControllers: [UIViewController] {
        let controller1 = UINavigationController(rootViewController: CreditIndexController())
        controller1.tabBarItem.title = "Кредитный рейтинг"
        controller1.tabBarItem.image = #imageLiteral(resourceName: "score")
        
        let controller2 = UINavigationController(rootViewController: HistoryController())
        controller2.tabBarItem.title = "Кредитная история"
        controller2.tabBarItem.image = #imageLiteral(resourceName: "credits")
        
        let controller3 = UINavigationController(rootViewController: InsuredEventsController())
        controller3.tabBarItem.title = "Страховые случаи"
        controller3.tabBarItem.image = #imageLiteral(resourceName: "requests")
        
        let controller4 = UINavigationController(rootViewController: ProfileController())
        controller4.tabBarItem.title = "Профиль"
        controller4.tabBarItem.image = #imageLiteral(resourceName: "user")
        
        return [controller1, controller2, controller3, controller4]
    }
}
